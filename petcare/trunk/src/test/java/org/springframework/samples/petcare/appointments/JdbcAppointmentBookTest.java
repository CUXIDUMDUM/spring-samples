package org.springframework.samples.petcare.appointments;

import static org.junit.Assert.assertEquals;

import java.util.List;
import java.util.Map;

import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class JdbcAppointmentBookTest {

	@Autowired
	private AppointmentBook appointmentBook;

	@Test
	@Transactional
	public void testGetAppointmentsForDay() {
		Map<String, List<Appointment>> appointments = appointmentBook.getAppointmentsForDay(new LocalDate(2009, 10, 23));
		assertEquals(2, appointments.size());
	}

	@Test
	@Transactional
	@Ignore
	public void addAppointment() {
		AppointmentForm form = new AppointmentForm();
		appointmentBook.addAppointment(form);
		Map<String, List<Appointment>> appointments = this.appointmentBook.getAppointmentsForDay(new LocalDate(2009, 12, 29));
		assertEquals(1, appointments.size());
		Appointment a = appointments.get("Dwight Howard").iterator().next();
		assertEquals(new DateTime(2009, 12, 29, 8, 0, 0, 0), a.getDateTime());
		assertEquals("Macy", a.getPatient());
		assertEquals("Keith Donald", a.getClient());
		assertEquals("1-205-333-5555", a.getClientPhone());
	}

}
