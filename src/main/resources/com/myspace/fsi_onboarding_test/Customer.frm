{"id":"32b2a849-5543-43f6-a7ca-c0f630b0210a","name":"Customer","model":{"source":"INTERNAL","className":"com.myspace.fsi_onboarding_test.Customer","name":"customer","properties":[{"name":"customerName","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":false},"metaData":{"entries":[]}},{"name":"customerDOB","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":false},"metaData":{"entries":[]}},{"name":"placeOfBirth","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":false},"metaData":{"entries":[]}},{"name":"residency","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":false},"metaData":{"entries":[]}},{"name":"citizenship","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":false},"metaData":{"entries":[]}},{"name":"taxIdentificationNumber","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":false},"metaData":{"entries":[]}},{"name":"immigrant","typeInfo":{"type":"BASE","className":"java.lang.Boolean","multiple":false},"metaData":{"entries":[]}},{"name":"immigrantStatus","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":false},"metaData":{"entries":[]}},{"name":"substantialPresence","typeInfo":{"type":"BASE","className":"java.lang.Boolean","multiple":false},"metaData":{"entries":[]}},{"name":"address","typeInfo":{"type":"OBJECT","className":"com.myspace.fsi_onboarding_test.Address","multiple":false},"metaData":{"entries":[]}},{"name":"questionnaire","typeInfo":{"type":"OBJECT","className":"com.myspace.fsi_onboarding_test.QuestionAndAnswer","multiple":false},"metaData":{"entries":[]}},{"name":"documentName","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":false},"metaData":{"entries":[]}},{"name":"creditScore","typeInfo":{"type":"BASE","className":"java.lang.Integer","multiple":false},"metaData":{"entries":[]}},{"name":"creditApproved","typeInfo":{"type":"BASE","className":"java.lang.Boolean","multiple":false},"metaData":{"entries":[]}},{"name":"documentsRequired","typeInfo":{"type":"BASE","className":"java.lang.String","multiple":true},"metaData":{"entries":[]}}],"formModelType":"org.kie.workbench.common.forms.data.modeller.model.DataObjectFormModel"},"fields":[{"maxLength":100,"placeHolder":"CustomerName","id":"field_116522398198242E11","name":"customerName","label":"CustomerName","required":false,"readOnly":false,"validateOnChange":true,"binding":"customerName","standaloneClassName":"java.lang.String","code":"TextBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.textBox.definition.TextBoxFieldDefinition"},{"maxLength":100,"placeHolder":"CustomerDOB","id":"field_663385592816356E11","name":"customerDOB","label":"CustomerDOB","required":false,"readOnly":false,"validateOnChange":true,"binding":"customerDOB","standaloneClassName":"java.lang.String","code":"TextBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.textBox.definition.TextBoxFieldDefinition"},{"maxLength":100,"placeHolder":"PlaceOfBirth","id":"field_483289242516112E12","name":"placeOfBirth","label":"PlaceOfBirth","required":false,"readOnly":false,"validateOnChange":true,"binding":"placeOfBirth","standaloneClassName":"java.lang.String","code":"TextBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.textBox.definition.TextBoxFieldDefinition"},{"maxLength":100,"placeHolder":"Residency","id":"field_5077826725505986E12","name":"residency","label":"Residency","required":false,"readOnly":false,"validateOnChange":true,"binding":"residency","standaloneClassName":"java.lang.String","code":"TextBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.textBox.definition.TextBoxFieldDefinition"},{"maxLength":100,"placeHolder":"Citizenship","id":"field_0658887222027025E12","name":"citizenship","label":"Citizenship","required":false,"readOnly":false,"validateOnChange":true,"binding":"citizenship","standaloneClassName":"java.lang.String","code":"TextBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.textBox.definition.TextBoxFieldDefinition"},{"maxLength":100,"placeHolder":"TaxIdentificationNumber","id":"field_4246401691458447E12","name":"taxIdentificationNumber","label":"TaxIdentificationNumber","required":false,"readOnly":false,"validateOnChange":true,"binding":"taxIdentificationNumber","standaloneClassName":"java.lang.String","code":"TextBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.textBox.definition.TextBoxFieldDefinition"},{"id":"field_4418251602708281E12","name":"immigrant","label":"Immigrant","required":false,"readOnly":false,"validateOnChange":true,"binding":"immigrant","standaloneClassName":"java.lang.Boolean","code":"CheckBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.checkBox.definition.CheckBoxFieldDefinition"},{"maxLength":100,"placeHolder":"ImmigrantStatus","id":"field_5160822739913635E12","name":"immigrantStatus","label":"ImmigrantStatus","required":false,"readOnly":false,"validateOnChange":true,"binding":"immigrantStatus","standaloneClassName":"java.lang.String","code":"TextBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.textBox.definition.TextBoxFieldDefinition"},{"id":"field_3114433860022012E11","name":"substantialPresence","label":"SubstantialPresence","required":false,"readOnly":false,"validateOnChange":true,"binding":"substantialPresence","standaloneClassName":"java.lang.Boolean","code":"CheckBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.checkBox.definition.CheckBoxFieldDefinition"},{"nestedForm":"0cc6e0e9-ae74-4cbf-ba32-ad8dd4359c13","container":"FIELD_SET","id":"field_1991231214940938E12","name":"address","label":"Address","required":false,"readOnly":false,"validateOnChange":true,"binding":"address","standaloneClassName":"com.myspace.fsi_onboarding_test.Address","code":"SubForm","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.relations.subForm.definition.SubFormFieldDefinition"},{"nestedForm":"bd2c9f8c-98d4-4f36-a920-a8c97c427aa1","container":"FIELD_SET","id":"field_700974449031176E11","name":"questionnaire","label":"Questionnaire","required":false,"readOnly":false,"validateOnChange":true,"binding":"questionnaire","standaloneClassName":"com.myspace.fsi_onboarding_test.QuestionAndAnswer","code":"SubForm","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.relations.subForm.definition.SubFormFieldDefinition"},{"maxLength":100,"placeHolder":"DocumentName","id":"field_3719373876766896E11","name":"documentName","label":"DocumentName","required":false,"readOnly":false,"validateOnChange":true,"binding":"documentName","standaloneClassName":"java.lang.String","code":"TextBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.textBox.definition.TextBoxFieldDefinition"},{"placeHolder":"CreditScore","maxLength":100,"id":"field_3398330929860388E12","name":"creditScore","label":"CreditScore","required":false,"readOnly":false,"validateOnChange":true,"binding":"creditScore","standaloneClassName":"java.lang.Integer","code":"IntegerBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.integerBox.definition.IntegerBoxFieldDefinition"},{"id":"field_934124968248253E11","name":"creditApproved","label":"CreditApproved","required":false,"readOnly":false,"validateOnChange":true,"binding":"creditApproved","standaloneClassName":"java.lang.Boolean","code":"CheckBox","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.checkBox.definition.CheckBoxFieldDefinition"},{"listOfValues":[],"maxDropdownElements":10,"maxElementsOnTitle":5,"allowFilter":true,"allowClearSelection":true,"id":"field_849318315415799E10","name":"documentsRequired","label":"DocumentsRequired","required":false,"readOnly":false,"validateOnChange":true,"binding":"documentsRequired","standaloneClassName":"java.lang.String","code":"MultipleSelector","serializedFieldClassName":"org.kie.workbench.common.forms.fields.shared.fieldTypes.basic.lists.selector.impl.StringMultipleSelectorFieldDefinition"}],"layoutTemplate":{"version":2,"style":"FLUID","layoutProperties":{},"rows":[{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_116522398198242E11","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_663385592816356E11","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_483289242516112E12","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_5077826725505986E12","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_0658887222027025E12","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_4246401691458447E12","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_4418251602708281E12","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_5160822739913635E12","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_3114433860022012E11","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_1991231214940938E12","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_700974449031176E11","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_3719373876766896E11","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_3398330929860388E12","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_934124968248253E11","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]},{"properties":{},"layoutColumns":[{"span":"12","height":"12","properties":{},"rows":[],"layoutComponents":[{"dragTypeName":"org.kie.workbench.common.forms.editor.client.editor.rendering.EditorFieldLayoutComponent","properties":{"field_id":"field_849318315415799E10","form_id":"32b2a849-5543-43f6-a7ca-c0f630b0210a"}}]}]}]}}