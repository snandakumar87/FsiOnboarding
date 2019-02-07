[CmdletBinding()]
param (
    [string]$command = "",
    [string]$demo = "",
    [string]$user = "",
    [string]${project-suffix} = "",
    [string]${run-verify} = "",
    [switch]${with-imagestreams} = $false,
    [string]${pv-capacity} = "512Mi",
    [switch]$h = $false,
    [switch]$help = $false
)

$SCRIPT_DIR= Split-Path $myInvocation.MyCommand.Path


. $SCRIPT_DIR\provision-properties-static.ps1

#TODO Implement validation of parameters like in the bash script, for example to verify correctness of the username.

if ((Get-Command "oc" -ErrorAction SilentlyContinue) -eq $null)
{
   Write-Output "The oc client tools need to be installed to connect to OpenShift."
   Write-Output "Download it from https://www.openshift.org/download.html and confirm that ""oc version"" runs.`n"
   exit
}

$scriptName = $myInvocation.MyCommand.Name

################################################################################
# Provisioning script to deploy the demo on an OpenShift environment           #
################################################################################

Function Usage() {
  Write-Output ""
  Write-Output "Usage:"
  Write-Output " $scriptName -command [command] -demo [demo-name] [options]"
  Write-Output " $scriptName -help"
  Write-Output ""
  Write-Output "Example:"
  Write-Output " $scriptName -command setup -demo $PRJ_NAME -project-suffix s40d"
  Write-Output ""
  Write-Output "COMMANDS:"
  Write-Output "   setup                    Set up the demo projects and deploy demo apps"
  Write-Output "   deploy                   Deploy demo apps"
  Write-Output "   delete                   Clean up and remove demo projects and objects"
  Write-Output "   verify                   Verify the demo is deployed correctly"
  Write-Output "   idle                     Make all demo services idle"
  Write-Output ""
  Write-Output "DEMOS:"
  Write-Output "   $PRJ_NAME                $PRJ_DESCRIPTION"
  Write-Output ""
  Write-Output "OPTIONS:"
  Write-Output "   -user [username]         The admin user for the demo projects. mandatory if logged in as system:admin"
  Write-Output "   -project-suffix [suffix] Suffix to be added to demo project names e.g. ci-SUFFIX. If empty, user will be used as suffix."
  Write-Output "   -run-verify              Run verify after provisioning"
  Write-Output "   -with-imagestreams       Creates the image streams in the project. Useful when required ImageStreams are not available in the 'openshift' namespace and cannot be provisioned in that 'namespace'."
  Write-Output "   -pv-capacity [capacity]  Capacity of the persistent volume. Defaults to 512Mi as set by the Red Hat Decision Manager OpenShift template."
  Write-Output ""
}

$ARG_USERNAME=$user
$ARG_PROJECT_SUFFIX=${project-suffix}
$ARG_COMMAND=$command
$ARG_RUN_VERIFY=${run-verify}
$ARG_WITH_IMAGESTREAMS=${with-imagestreams}
$ARG_PV_CAPACITY=${pv-capacity}
$ARG_DEMO=$demo

if ($h -Or $help) {
  Usage
  exit
}

$commands = "info","setup","deploy","delete","verify","idle"
if (!$commands.Contains($ARG_COMMAND)) {
  Write-Output "Error: Unrecognized command: $ARG_COMMAND"
  Write-Output "Please run '$scriptName -help' to see the list of accepted commands and options."
  exit
}

################################################################################
# Configuration                                                                #
################################################################################

$LOGGEDIN_USER=Invoke-Expression "oc whoami"
if (-not ([string]::IsNullOrEmpty($ARG_USERNAME)))
{
  $OPENSHIFT_USER = $ARG_USERNAME
} else {
  $OPENSHIFT_USER = $LOGGEDIN_USER
}


#if (-not ([string]::IsNullOrEmpty($ARG_PROJECT_SUFFIX)))
#{
#  $PRJ_SUFFIX = $ARG_PROJECT_SUFFIX
#} else {
#  $PRJ_SUFFIX =  %{$OPENSHIFT_USER -creplace "[^-a-z0-9]","-"}
#}

#$PRJ=@("rhpam7-mortgage-$PRJ_SUFFIX","RHPAM7 Mortgage Demo","Red Hat Process Automation Manager 7 Mortgage Demo")

. $SCRIPT_DIR\provision-properties-dynamic.ps1

# KIE Parameters
$KIE_ADMIN_USER="adminUser"
$KIE_ADMIN_PWD="test1234!"
$KIE_SERVER_CONTROLLER_USER="controllerUser"
$KIE_SERVER_CONTROLLER_PWD="test1234!"
$KIE_SERVER_USER="executionUser"
$KIE_SERVER_PWD="test1234!"

################################################################################
# DEMO MATRIX                                                                  #
################################################################################

switch ( $ARG_DEMO )
{
  "$PRJ_NAME" {
    $DEMO_NAME=$($PRJ[2])
  }
  default {
    Write-Output "Error: Invalid demo name: '$ARG_DEMO'"
    Usage
    exit
  }
}

################################################################################
# Functions                                                                    #
################################################################################

Function Write-Output-Header($echo) {
  Write-Output ""
  Write-Output "########################################################################"
  Write-Output "$echo"
  Write-Output "########################################################################"
}

Function Call-Oc($command, [bool]$out, $errorMessage, [bool]$doexit) {
  try {
    if ($out) {
      oc $command.split()
    } else {
      oc $command.split() | out-null
    }
    if ($lastexitcode) {
      throw $er
    }
  } catch {
    Write-Error "$errorMessage"
    if ($doexit) {
      exit 255
    }
  }
}

Function Print-Info() {
  Write-Output-Header "Configuration"

  Invoke-Expression "oc version" | select -last 3| select -first 1 | %{$_ -cmatch ".*https://(?<url>.*)"}
  $OPENSHIFT_MASTER=$matches['url']

  Write-Output "Demo name:        $ARG_DEMO"
  Write-Output "Project name:     $($PRJ[0])"
  Write-Output "OpenShift master: $OPENSHIFT_MASTER"
  Write-Output "Current user:     $LOGGEDIN_USER"
  Write-Output "Project suffix:   $PRJ_SUFFIX"
}

Function Pre-Condition-Check() {
  Write-Output-Header "Checking pre-conditions"
}

# waits while the condition is true until it becomes false or it times out
Function Wait-While-Empty($name, $timeout, $condition) {
  #TODO: Implement
}

<#
function wait_while_empty() {
  local _NAME=$1
  local _TIMEOUT=$(($2/5))
  local _CONDITION=$3

  echo "Waiting for $_NAME to be ready..."
  local x=1
  while [ -z "$(eval ${_CONDITION})" ]
  do
    echo "."
    sleep 5
    x=$(( $x + 1 ))
    if [ $x -gt $_TIMEOUT ]
    then
      echo "$_NAME still not ready, I GIVE UP!"
      exit 255
    fi
  done

  echo "$_NAME is ready."
}
#>

Function Create-Projects() {
    Write-Output-Header "Creating project..."

    Write-Output-Header "Creating project $($PRJ[0])"
    $argList = "new-project ""$($PRJ[0])"" --display-name=""$($PRJ[1])"" --description=""$($PRJ[2])"""

    Call-Oc $argList $False "Error occurred during project creation." $True
}


Function Import-ImageStreams-And-Templates() {
  Write-Output-Header "Importing Image Streams"
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/rhpam70-image-streams.yaml" $True "Error importing Image Streams" $True
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-openshift/application-templates/ose-v1.4.15/openjdk/openjdk18-image-stream.json" $True "Error importing Image Streams" $True

  Write-Output-Header "Importing Templates"
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/templates/rhpam70-authoring.yaml" $True "Error importing Template" $True
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/templates/rhpam70-kieserver-externaldb.yaml" $True "Error importing Template" $True
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/templates/rhpam70-kieserver-mysql.yaml" $True "Error importing Template" $True
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/templates/rhpam70-kieserver-postgresql.yaml" $True "Error importing Template" $True
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/templates/rhpam70-prod-immutable-kieserver.yaml" $True "Error importing Template" $True
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/templates/rhpam70-prod-immutable-monitor.yaml" $True "Error importing Template" $True
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/templates/rhpam70-sit.yaml" $True "Error importing Template" $True
  Call-Oc "create -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/templates/rhpam70-trial-ephemeral.yaml" $True "Error importing Template" $True
}

Function Import-Secrets-And-Service-Account() {
  Write-Output-Header "Importing secrets and service account."
  oc process -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/example-app-secret-template.yaml | oc create -f -
  oc process -f https://raw.githubusercontent.com/jboss-container-images/rhpam-7-openshift-image/$OPENSHIFT_PAM7_TEMPLATES_TAG/example-app-secret-template.yaml -p SECRET_NAME=kieserver-app-secret | oc create -f -

  Call-Oc "create serviceaccount businesscentral-service-account" $True "Error creating service account." $True
  Call-Oc "create serviceaccount kieserver-service-account" $True "Error creating service account." $True
  Call-Oc "secrets link --for=mount businesscentral-service-account businesscentral-app-secret" $True "Error linking businesscentral-service-account to secret"
  Call-Oc "secrets link --for=mount kieserver-service-account kieserver-app-secret" $True "Error linking kieserver-service-account to secret"
}

Function Create-Application() {
  Write-Output-Header "Creating BPM Suite 7 Application config."

  $IMAGE_STREAM_NAMESPACE="openshift"

  if ($ARG_WITH_IMAGESTREAMS) {
    $IMAGE_STREAM_NAMESPACE=$($PRJ[0])
  }

  oc process -f $SCRIPT_DIR/rhpam70-businesscentral-openshift-with-users.yaml -p DOCKERFILE_REPOSITORY="https://github.com/jbossdemocentral/rhpam7-order-it-hw-demo" -p DOCKERFILE_REF="master" -p DOCKERFILE_CONTEXT="support/openshift/rhpam7-businesscentral-openshift-with-users" -n $($PRJ[0]) | oc create -n $($PRJ[0]) -f -

  oc create configmap setup-demo-scripts --from-file=$SCRIPT_DIR/bc-clone-git-repository.sh,$SCRIPT_DIR/provision-properties-static.sh

  $argList = "new-app --template=rhpam70-authoring"`
      + " -p APPLICATION_NAME=""$ARG_DEMO""" `
      + " -p IMAGE_STREAM_NAMESPACE=""$IMAGE_STREAM_NAMESPACE""" `
      + " -p IMAGE_STREAM_TAG=""1.0""" `
      + " -p KIE_ADMIN_USER=""$KIE_ADMIN_USER""" `
      + " -p KIE_ADMIN_PWD=""$KIE_ADMIN_PWD""" `
      + " -p KIE_SERVER_CONTROLLER_USER=""$KIE_SERVER_CONTROLLER_USER""" `
      + " -p KIE_SERVER_CONTROLLER_PWD=""$KIE_SERVER_CONTROLLER_PWD""" `
      + " -p KIE_SERVER_USER=""$KIE_SERVER_USER""" `
      + " -p KIE_SERVER_PWD=""$KIE_SERVER_PWD""" `
      + " -p BUSINESS_CENTRAL_MAVEN_USERNAME=""mavenUser""" `
      + " -p BUSINESS_CENTRAL_MAVEN_PASSWORD=""test1234!""" `
      + " -p BUSINESS_CENTRAL_HTTPS_SECRET=""businesscentral-app-secret""" `
      + " -p KIE_SERVER_HTTPS_SECRET=""kieserver-app-secret""" `
      + " -p BUSINESS_CENTRAL_MEMORY_LIMIT=""2Gi"""

  Call-Oc $argList $True "Error creating application." $True

  # Give the system some time to create the DC, etc. before we trigger a deployment config change.
  Start-Sleep -s 5

  oc set volume dc/$ARG_DEMO-rhpamcentr --add --name=config-volume --configmap-name=setup-demo-scripts  --mount-path=/tmp/config-files
  oc set deployment-hook dc/$ARG_DEMO-rhpamcentr --post -c $ARG_DEMO-rhpamcentr -e BC_URL="http://$ARG_DEMO-rhpamcent" -v config-volume --failure-policy=abort -- /bin/bash /tmp/config-files/bc-clone-git-repository.sh

  oc patch dc/$ARG_DEMO-rhpamcentr --type='json' -p "[{'op': 'replace', 'path': '/spec/triggers/0/imageChangeParams/from/name', 'value': 'rhpam70-businesscentral-openshift-with-users:latest'}]"

  $argList = "new-app java:8~https://github.com/jbossdemocentral/rhpam7-order-it-hw-demo-springboot-app" `
              + " --name rhpam7-oih-order-app" `
              + " -e JAVA_OPTIONS=""-Dorg.kie.server.repo=/data -Dorg.jbpm.document.storage=/data/docs -Dorder.service.location=http://rhpam7-oih-order-mgmt-app:8080 -Dorg.kie.server.controller.user=controllerUser -Dorg.kie.server.controller.pwd=test1234! -Dspring.profiles.active=openshift-rhpam""" `
              + " -e KIE_MAVEN_REPO_USER=mavenUser" `
              + " -e KIE_MAVEN_REPO_PASSWORD=test1234!" `
              + " -e KIE_MAVEN_REPO=http://$ARG_DEMO-rhpamcentr:8080/maven2" `
              + " -e GC_MAX_METASPACE_SIZE=192"

  Call-Oc $argList $True "Error creating application." $True

  oc create configmap rhpam7-oih-order-app-settings-config-map --from-file=$SCRIPT_DIR/settings.xml -n $($PRJ[0])

  oc set volume dc/rhpam7-oih-order-app --add -m /home/jboss/.m2 -t configmap --configmap-name=rhpam7-oih-order-app-settings-config-map -n $($PRJ[0])

  oc set volume dc/rhpam7-oih-order-app --add --claim-size 100Mi --mount-path /data --name rhpam7-oih-order-app-data -n $($PRJ[0])

  oc expose service rhpam7-oih-order-app -n $($PRJ[0])

  $ORDER_IT_HW_APP_ROUTE=oc get route rhpam7-oih-order-app | select -index 1 | %{$_ -split "\s+"} | select -index 1

  #sed s/.*kieserver\.location.*/kieserver\.location=http:\\/\\/$ORDER_IT_HW_APP_ROUTE\\/rest\\/server/g $SCRIPT_DIR/application-openshift-rhpam.properties.orig > $SCRIPT_DIR/application-openshift-rhpam.properties
  cat $SCRIPT_DIR/application-openshift-rhpam.properties.orig | %{$_ -replace ".*kieserver.location=.*", "kieserver.location=http://$ORDER_IT_HW_APP_ROUTE/rest/server"} > $SCRIPT_DIR/application-openshift-rhpam.properties

  oc create configmap rhpam7-oih-order-app-properties-config-map --from-file=$SCRIPT_DIR/application-openshift-rhpam.properties -n $($PRJ[0])

  oc set volume dc/rhpam7-oih-order-app --add -m /deployments/config -t configmap --configmap-name=rhpam7-oih-order-app-properties-config-map -n $($PRJ[0])

  $argList="new-app java:8~https://github.com/jbossdemocentral/rhpam7-order-it-hw-demo-vertx-app" `
            + " --name rhpam7-oih-order-mgmt-app" `
            + " -e JAVA_OPTIONS=""-Duser=maciek -Dpassword=maciek1!""" `
            + " -e JAVA_APP_JAR=order-mgmt-app-1.0.0-fat.jar"

  Call-Oc $argList $True "Error creating application." $True

  oc expose service rhpam7-oih-order-mgmt-app -n $($PRJ[0])
}

Function Build-And-Deploy() {
  Write-Output-Header "Starting OpenShift build and deploy..."
  #TODO: Implement function
  #oc start-build $ARG_DEMO-buscentr
}

Function Verify-Build-And-Deployments() {
  #TODO: Implement function.
  Write-Output-Header "Verifying build and deployments"
  # verify builds
  # We don't have any builds, so can skip this.
  #local _BUILDS_FAILED=false
  #for buildconfig in optaplanner-employee-rostering
  #do
  #  if [ -n "$(oc get builds -n $PRJ | grep $buildconfig | grep Failed)" ] && [ -z "$(oc get builds -n $PRJ | grep $buildconfig | grep Complete)" ]; then
  #    _BUILDS_FAILED=true
  #    echo "WARNING: Build $project/$buildconfig has failed..."
  #  fi
  #done

  # Verify deployments
  Verify-Deployments-In-Projects @($($PRJ[0]))
}

Function Verify-Deployments-In-Projects($projects) {
  Foreach ($project in $projects)
  {
      #TODO Implement function

      $argList1 = "get dc -l comp-type=database -n $project -o=custom-columns=:.metadata.name 2>/dev/null"
      $argList2 = "get dc -l comp-type!=database -n $project -o=custom-columns=:.metadata.name 2>/dev/null"

      $deployments=@($(Invoke-Expression "oc $argList1" 2>/dev/null))
      $deployments+=$(Invoke-Expression "oc $argList2" 2>/dev/null)
      Write-Output "Deployments: $deployments"

      Foreach($dc in $deployments) {
        if (!([string]::IsNullOrEmpty($dc))) {
          $dc_status=$(Invoke-Expression "oc get dc $dc -n $project -o=custom-columns=:.spec.replicas,:.status.availableReplicas")
          Write-Output "DC Status for $dc is: $dc_status"
        }
      }
  }
}

<#
function verify_deployments_in_projects() {
  for project in "$@"
  do
    local deployments="$(oc get dc -l comp-type=database -n $project -o=custom-columns=:.metadata.name 2>/dev/null) $(oc get dc -l comp-type!=database -n $project -o=custom-columns=:.metadata.name 2>/dev/null)"
    for dc in $deployments; do
      dc_status=$(oc get dc $dc -n $project -o=custom-columns=:.spec.replicas,:.status.availableReplicas)
      dc_replicas=$(echo $dc_status | sed "s/^\([0-9]\+\) \([0-9]\+\)$/\1/")
      dc_available=$(echo $dc_status | sed "s/^\([0-9]\+\) \([0-9]\+\)$/\2/")

      if [ "$dc_available" -lt "$dc_replicas" ] ; then
        echo "WARNING: Deployment $project/$dc: FAILED"
        echo
        echo "Starting a new deployment for $project/$dc ..."
        echo
        oc rollout cancel dc/$dc -n $project >/dev/null
        sleep 5
        oc rollout latest dc/$dc -n $project
        oc rollout status dc/$dc -n $project
      else
        echo "Deployment $project/$dc: OK"
      fi
    done
  done
}
#>

Function Make-Idle() {
  Write-Output-Header "Idling Services"
  $argList = "idle -n $($PRJ[0]) --all"
  try {
    Call-Oc $argList $True "Error idling service." $True
  } catch {
    Write-Error "Error occurred during project idling."
    exit
  }

}

# GPTE convention
Function Set-Default-Project() {
  if ($LOGGEDIN_USER.equals("system:admin")) {
    Call-Oc "project default" $True "Error setting default project" $True
  }
}

################################################################################
# Main deployment                                                              #
################################################################################

if ( ($LOGGEDIN_USER.equals("system:admin")) -And ([string]::IsNullOrEmpty($ARG_USERNAME)) ) {
  # for verify and delete, -project-suffix is enough
  if ($ARG_COMMAND.equals("delete") -Or $ARG_COMMAND.equals("verify") -And ([string]::IsNullOrEmpty($ARG_PROJECT_SUFFIX)))   {
    Write-Output "-user or -project-suffix must be provided when running $ARG_COMMAND as 'system:admin'"
    exit 255
  } elseif (!($ARG_COMMAND.equals("delete")) -And !($ARG_COMMAND.equals("verify"))) {
    Write-Output "-user must be provided when running $ARG_COMMAND as 'system:admin'"
    exit 255
  }
}

$START = [int](Get-Date -UFormat %s)

Write-Output-Header "$DEMO_NAME $(Get-Date)"

switch ( $ARG_COMMAND )
{
  "info" {
    Write-Output "Printing information $DEMO_NAME ($ARG_DEMO)..."
    Print-Info
  }
  "delete" {
    Write-Output "Delete $DEMO_NAME ($ARG_DEMO)..."
    $argList = "delete project $($PRJ[0])"
    try {
    	Invoke-Expression "oc $argList"
    } catch {
    	Write-Error "Error occurred during project deletion."
    	exit
    }
  }
  "verify" {
    # TODO: Implement verification.
    Write-Output "Verification has not yet been implemented..."
    #Write-Output "Verifying $DEMO_NAME ($ARG_DEMO)..."
    #Print-Info
    #Verify-Build-And-Deployments
  }
  "idle" {
    Write-Output "Idling $DEMO_NAME ($ARG_DEMO)..."
    Print-Info
    Make-Idle
  }
  "setup" {
    echo "Setting up and deploying $DEMO_NAME ($ARG_DEMO)..."

    Print-Info
    #Pre-Condition-Check
    Create-Projects

    if ($ARG_WITH_IMAGESTREAMS) {
      Import-ImageStreams-And-Templates
    }

    Import-Secrets-And-Service-Account

    Create-Application

    if ($ARG_RUN_VERIFY) {
      # TODO: Implement verification.
      Write-Output "Verification has not yet been implemented..."
      #Write-Output "Waiting for deployments to finish..."
      #Start-Sleep -s 30
      #Verify-Build-And-Deployments
    }

    #if [ "$ARG_RUN_VERIFY" = true ] ; then
    #    echo "Waiting for deployments to finish..."
    #  sleep 30
    #  verify_build_and_deployments
    #fi
  }
  default {
    Write-Output "Invalid command specified: '$ARG_COMMAND'"
    Usage
  }
}
#pushd ~ >/dev/null
<#
START=`date +%s`

echo_header "$DEMO_NAME ($(date))"

case "$ARG_COMMAND" in
    info)
      echo "Printing information $DEMO_NAME ($ARG_DEMO)..."
      print_info
      ;;
    delete)
        echo "Delete $DEMO_NAME ($ARG_DEMO)..."
        oc delete project ${PRJ[0]}
        ;;

    verify)
        echo "Verifying $DEMO_NAME ($ARG_DEMO)..."
        print_info
        verify_build_and_deployments
        ;;

    idle)
        echo "Idling $DEMO_NAME ($ARG_DEMO)..."
        print_info
        make_idle
        ;;

    setup)
        echo "Setting up and deploying $DEMO_NAME ($ARG_DEMO)..."

        print_info
        #pre_condition_check
        create_projects
        if [ "$ARG_WITH_IMAGESTREAMS" = true ] ; then
           import_imagestreams_and_templates
        fi
	      import_secrets_and_service_account

        create_application

        if [ "$ARG_RUN_VERIFY" = true ] ; then
          echo "Waiting for deployments to finish..."
          sleep 30
          verify_build_and_deployments
        fi
        ;;

    deploy)
        echo "Deploying $DEMO_NAME ($ARG_DEMO)..."

        print_info

        build_and_deploy

        if [ "$ARG_RUN_VERIFY" = true ] ; then
          echo "Waiting for deployments to finish..."
          sleep 30
          verify_build_and_deployments
        fi
        ;;

    *)
        echo "Invalid command specified: '$ARG_COMMAND'"
        usage
        ;;
esac
#>

Set-Default-Project

$END = [int](Get-Date -UFormat %s)
Write-Output ""
Write-Output "Provisioning done! (Completed in $([int]( ($END - $START)/60 )) min $(( ($END - $START)%60 )) sec)"
