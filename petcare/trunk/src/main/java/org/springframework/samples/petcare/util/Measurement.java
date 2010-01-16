package org.springframework.samples.petcare.util;

import java.math.BigDecimal;

public class Measurement {
	
	private BigDecimal amount;
	
	private Unit unit;

	public BigDecimal getAmount() {
		return amount;
	}

	public Unit getUnit() {
		return unit;
	}

}
