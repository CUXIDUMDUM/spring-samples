package org.springframework.samples.petclinic.appointments;

import javax.validation.constraints.NotNull;

import org.joda.time.LocalDate;
import org.joda.time.LocalTime;
import org.springframework.core.style.ToStringCreator;

public class AppointmentForm {

	@NotNull
	private Long doctor;

	@NotNull
	private Long client;

	@NotNull
	private Long patient;

	@NotNull
	private LocalDate date;

	@NotNull
	private LocalTime time;

	private String notes;

	public Long getDoctor() {
		return doctor;
	}

	public void setDoctor(Long doctor) {
		this.doctor = doctor;
	}

	public Long getClient() {
		return client;
	}

	public void setClient(Long client) {
		this.client = client;
	}

	public Long getPatient() {
		return patient;
	}

	public void setPatient(Long patient) {
		this.patient = patient;
	}

	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public LocalTime getTime() {
		return time;
	}

	public void setTime(LocalTime time) {
		this.time = time;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}
	
	public String toString() {
		return new ToStringCreator(this).append("date", date).append("time", time).append("patient", patient).toString();
	}

}
