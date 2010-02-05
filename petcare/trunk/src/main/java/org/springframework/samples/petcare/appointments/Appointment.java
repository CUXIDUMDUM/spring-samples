package org.springframework.samples.petcare.appointments;

import org.joda.time.DateTime;
import org.springframework.core.style.ToStringCreator;

public class Appointment {

	private DateTime dateTime;

	private String client;

	private String clientPhone;

	private String patient;

	private String notes;

	Appointment() {

	}

	public DateTime getDateTime() {
		return dateTime;
	}

	public void setDateTime(DateTime dateTime) {
		this.dateTime = dateTime;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getClientPhone() {
		return clientPhone;
	}

	public void setClientPhone(String clientPhone) {
		this.clientPhone = clientPhone;
	}

	public String getPatient() {
		return patient;
	}

	public void setPatient(String patient) {
		this.patient = patient;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String toString() {
		return new ToStringCreator(this).append("dateTime", dateTime).append("patient", patient).toString();
	}
}