package com.myspace.fsi_onboarding_test;

/**
 * This class was automatically generated by the data modeler tool.
 */

public class QuestionAndAnswer implements java.io.Serializable {

	static final long serialVersionUID = 1L;

	private java.lang.String questionId;
	private java.lang.String question;
	private java.lang.String answer;

	public QuestionAndAnswer() {
	}

	public java.lang.String getQuestionId() {
		return this.questionId;
	}

	public void setQuestionId(java.lang.String questionId) {
		this.questionId = questionId;
	}

	public java.lang.String getQuestion() {
		return this.question;
	}

	public void setQuestion(java.lang.String question) {
		this.question = question;
	}

	public java.lang.String getAnswer() {
		return this.answer;
	}

	public void setAnswer(java.lang.String answer) {
		this.answer = answer;
	}

	public QuestionAndAnswer(java.lang.String questionId,
			java.lang.String question, java.lang.String answer) {
		this.questionId = questionId;
		this.question = question;
		this.answer = answer;
	}

}