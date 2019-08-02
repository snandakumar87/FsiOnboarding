package com.myspace.fsi_onboarding_test;

/**
 * This class was automatically generated by the data modeler tool.
 */

public class Customer implements java.io.Serializable {

	static final long serialVersionUID = 1L;

	private java.lang.String customerName;
	private java.lang.String customerDOB;
	private java.lang.String placeOfBirth;
	private java.lang.String residency;
	private java.lang.String citizenship;
	private java.lang.String taxIdentificationNumber;
	private java.lang.Boolean immigrant;
	private java.lang.String immigrantStatus;
	private Boolean substantialPresence;

	private com.myspace.fsi_onboarding_test.Address address;

	private com.myspace.fsi_onboarding_test.QuestionAndAnswer questionnaire;

	private java.lang.String documentName;

	private java.lang.Integer creditScore;

	private java.lang.Boolean creditApproved;

	private java.util.List<java.lang.String> documentsRequired;

	public Customer() {
	}

	public java.lang.String getCustomerName() {
		return this.customerName;
	}

	public void setCustomerName(java.lang.String customerName) {
		this.customerName = customerName;
	}

	public java.lang.String getCustomerDOB() {
		return this.customerDOB;
	}

	public void setCustomerDOB(java.lang.String customerDOB) {
		this.customerDOB = customerDOB;
	}

	public java.lang.String getPlaceOfBirth() {
		return this.placeOfBirth;
	}

	public void setPlaceOfBirth(java.lang.String placeOfBirth) {
		this.placeOfBirth = placeOfBirth;
	}

	public java.lang.String getResidency() {
		return this.residency;
	}

	public void setResidency(java.lang.String residency) {
		this.residency = residency;
	}

	public java.lang.String getCitizenship() {
		return this.citizenship;
	}

	public void setCitizenship(java.lang.String citizenship) {
		this.citizenship = citizenship;
	}

	public java.lang.String getTaxIdentificationNumber() {
		return this.taxIdentificationNumber;
	}

	public void setTaxIdentificationNumber(
			java.lang.String taxIdentificationNumber) {
		this.taxIdentificationNumber = taxIdentificationNumber;
	}

	public java.lang.Boolean getImmigrant() {
		return this.immigrant;
	}

	public void setImmigrant(java.lang.Boolean immigrant) {
		this.immigrant = immigrant;
	}

	public java.lang.String getImmigrantStatus() {
		return this.immigrantStatus;
	}

	public void setImmigrantStatus(java.lang.String immigrantStatus) {
		this.immigrantStatus = immigrantStatus;
	}

	public com.myspace.fsi_onboarding_test.Address getAddress() {
		return this.address;
	}

	public void setAddress(com.myspace.fsi_onboarding_test.Address address) {
		this.address = address;
	}

	public com.myspace.fsi_onboarding_test.QuestionAndAnswer getQuestionnaire() {
		return this.questionnaire;
	}

	public void setQuestionnaire(
			com.myspace.fsi_onboarding_test.QuestionAndAnswer questionnaire) {
		this.questionnaire = questionnaire;
	}

	public java.lang.String getDocumentName() {
		return this.documentName;
	}

	public void setDocumentName(java.lang.String documentName) {
		this.documentName = documentName;
	}

	public java.lang.Integer getCreditScore() {
		return this.creditScore;
	}

	public void setCreditScore(java.lang.Integer creditScore) {
		this.creditScore = creditScore;
	}

	public java.lang.Boolean getCreditApproved() {
		return this.creditApproved;
	}

	public void setCreditApproved(java.lang.Boolean creditApproved) {
		this.creditApproved = creditApproved;
	}

	public String toString() {
		return this.customerName + ":" + this.citizenship + ":"
				+ this.creditScore + ":" + this.creditApproved + "::"
				+ this.documentsRequired + this.documentName + this.creditApproved;
	}

	public java.util.List<java.lang.String> getDocumentsRequired() {
		return this.documentsRequired;
	}

	public void setDocumentsRequired(
			java.util.List<java.lang.String> documentsRequired) {
		this.documentsRequired = documentsRequired;
	}

	public void addDoc() {

		if (null == this.documentsRequired) {
			documentsRequired = new java.util.ArrayList<String>();
		}
		documentsRequired.add(this.documentName);
		System.out.println("add doc" + this.documentName);
	}

	public java.lang.Boolean getSubstantialPresence() {
		return this.substantialPresence;
	}

	public void setSubstantialPresence(java.lang.Boolean substantialPresence) {
		this.substantialPresence = substantialPresence;
	}

	public Customer(java.lang.String customerName,
			java.lang.String customerDOB, java.lang.String placeOfBirth,
			java.lang.String residency, java.lang.String citizenship,
			java.lang.String taxIdentificationNumber,
			java.lang.Boolean immigrant, java.lang.String immigrantStatus,
			java.lang.Boolean substantialPresence,
			com.myspace.fsi_onboarding_test.Address address,
			com.myspace.fsi_onboarding_test.QuestionAndAnswer questionnaire,
			java.lang.String documentName, java.lang.Integer creditScore,
			java.lang.Boolean creditApproved,
			java.util.List<java.lang.String> documentsRequired) {
		this.customerName = customerName;
		this.customerDOB = customerDOB;
		this.placeOfBirth = placeOfBirth;
		this.residency = residency;
		this.citizenship = citizenship;
		this.taxIdentificationNumber = taxIdentificationNumber;
		this.immigrant = immigrant;
		this.immigrantStatus = immigrantStatus;
		this.substantialPresence = substantialPresence;
		this.address = address;
		this.questionnaire = questionnaire;
		this.documentName = documentName;
		this.creditScore = creditScore;
		this.creditApproved = creditApproved;
		this.documentsRequired = documentsRequired;
	}

}