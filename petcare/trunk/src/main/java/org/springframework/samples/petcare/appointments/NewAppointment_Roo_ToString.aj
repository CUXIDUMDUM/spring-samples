package org.springframework.samples.petcare.appointments;

import java.lang.String;

privileged aspect NewAppointment_Roo_ToString {
    
    public String NewAppointment.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Time: ").append(getTime()).append(", ");        
        sb.append("PatientId: ").append(getPatientId()).append(", ");        
        sb.append("Reason: ").append(getReason());        
        return sb.toString();        
    }    
    
}
