package com.myspace.fsi_onboarding_test;

/**
 * This class was automatically generated by the data modeler tool.
 */

public class Address implements java.io.Serializable {

	static final long serialVersionUID = 1L;

	private java.lang.String street;
	private java.lang.String city;
	private java.lang.String state;
	private java.lang.String country;

	public Address() {
	}

	public java.lang.String getStreet() {
		return this.street;
	}

	public void setStreet(java.lang.String street) {
		this.street = street;
	}

	public java.lang.String getCity() {
		return this.city;
	}

	public void setCity(java.lang.String city) {
		this.city = city;
	}

	public java.lang.String getState() {
		return this.state;
	}

	public void setState(java.lang.String state) {
		this.state = state;
	}

	public java.lang.String getCountry() {
		return this.country;
	}

	public void setCountry(java.lang.String country) {
		this.country = country;
	}

	public Address(java.lang.String street, java.lang.String city,
			java.lang.String state, java.lang.String country) {
		this.street = street;
		this.city = city;
		this.state = state;
		this.country = country;
	}

}