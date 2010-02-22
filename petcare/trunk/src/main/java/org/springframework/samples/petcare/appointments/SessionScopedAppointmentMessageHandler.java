package org.springframework.samples.petcare.appointments;

import java.util.List;

import org.joda.time.LocalDate;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.integration.channel.PollableChannel;
import org.springframework.integration.channel.QueueChannel;
import org.springframework.integration.channel.SubscribableChannel;
import org.springframework.integration.core.Message;
import org.springframework.integration.message.MessageDeliveryException;
import org.springframework.integration.message.MessageHandler;
import org.springframework.integration.message.MessageHandlingException;
import org.springframework.integration.message.MessageRejectedException;
import org.springframework.integration.selector.MessageSelector;
import org.springframework.stereotype.Component;

@Component
@Scope(value="session", proxyMode=ScopedProxyMode.INTERFACES)
public class SessionScopedAppointmentMessageHandler implements InitializingBean, DisposableBean, MessageHandler, AppointmentMessageHandler {

	private SubscribableChannel messageChannel;

	private AppointmentMessageSelector messageSelector = new AppointmentMessageSelector();
	
	private PollableChannel pollableChannel = new QueueChannel();
	
	@Autowired
	public SessionScopedAppointmentMessageHandler(@Qualifier("notifications") SubscribableChannel messageChannel) {
		this.messageChannel = messageChannel;
	}

	public void afterPropertiesSet() throws Exception {
		this.messageChannel.subscribe(this);
	}

	public void destroy() throws Exception {
		this.messageChannel.unsubscribe(this);
	}	

	public void setDay(LocalDate day) {
		this.messageSelector.setDay(day);
	}
	
	public void handleMessage(Message<?> message) throws MessageRejectedException, MessageHandlingException, MessageDeliveryException {
		if (messageSelector.accept(message)) {
			pollableChannel.send(message);
		}
	}

	public List<Message<?>> pollMessages() {
		return pollableChannel.clear();
	}
	
	// internal helpers
	
	private static class AppointmentMessageSelector implements MessageSelector {

		private LocalDate day;
		
		public void setDay(LocalDate day) {
			this.day = day;
		}

		public boolean accept(Message<?> message) {
			if (message.getHeaders().get("element").equals("appointmentCalendar")) {
				Appointment appointment = (Appointment) message.getPayload();
				if (appointment.getStartTime().toLocalDate().equals(day)) {
					return true;
				}
			}
			return false;
		}
	}

}
