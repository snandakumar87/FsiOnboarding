package com.myspace.fsi_onboarding_test;

/**
 * This class was automatically generated by the data modeler tool.
 */

public class Applicant implements java.io.Serializable {

	static final long serialVersionUID = 1L;

	private java.lang.String applicantName;
	private java.lang.String applicantAddress;

	public Applicant() {
	}

	public java.lang.String getApplicantName() {
		return this.applicantName;
	}

	public void setApplicantName(java.lang.String applicantName) {
		this.applicantName = applicantName;
	}

	public java.lang.String getApplicantAddress() {
		return this.applicantAddress;
	}

	public void setApplicantAddress(java.lang.String applicantAddress) {
		this.applicantAddress = applicantAddress;
	}

	public Applicant(java.lang.String applicantName,
			java.lang.String applicantAddress) {
		this.applicantName = applicantName;
		this.applicantAddress = applicantAddress;
	}

}