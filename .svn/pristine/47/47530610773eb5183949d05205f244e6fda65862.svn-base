package com.hwfs.batch.guide.sample.dto;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 배치 샘플 CustomerCredit
 * @ClassName CustomerCredit.java
 * @Description CustomerCredit Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2013. 8. 2.   kksoo        최초생성
 * </pre>
 * @author KSF시스템 : AA kksoo
 * @since 2013. 8. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2013 by KSF, All right reserved.
 * </pre>
 */

@Entity
@Table(name = "CUSTOMER")
public class CustomerCreditDTO {

	// field "id"
	@Id
	private int id;

	// field "name"
	private String name;

	// field "credit"
	private BigDecimal credit;

	/**
	 * 생성자
	 */
	public CustomerCreditDTO() {
	}

	/**
	 * 생성자
	 * @param id
	 * @param name
	 * @param credit
	 */
	public CustomerCreditDTO(int id, String name, BigDecimal credit) {
		this.id = id;
		this.name = name;
		this.credit = credit;
		
		
	}

	/**
	 * field 내용을 String으로 return
	 */
	public String toString() {
		return "CustomerCredit [id=" + id + ",name=" + name + ", credit=" + credit + "]";
	}

	/**
	 * credit getter
	 * @return
	 */
	public BigDecimal getCredit() {
		return credit;
	}

	/**
	 * id getter
	 * @return
	 */
	public int getId() {
		return id;
	}

	/**
	 * id setter
	 * @param id
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * credit setter
	 * @param credit
	 */
	public void setCredit(BigDecimal credit) {
		this.credit = credit;
	}

	/**
	 * name getter
	 * @return
	 */
	public String getName() {
		return name;
	}

	/**
	 * name setter
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * credit field를 증가
	 * @param sum credit에 더하는 수
	 * @return credit이 증가된 새로운 객체
	 */
	public CustomerCreditDTO increaseCreditBy(BigDecimal sum) {
		CustomerCreditDTO newCredit = new CustomerCreditDTO();
		newCredit.credit = this.credit.add(sum);
		newCredit.name = this.name;
		newCredit.id = this.id;
		return newCredit;
	}

	/**
	 * Object가 CustomerCredit인지 판단
	 */
	public boolean equals(Object o) {
		return (o instanceof CustomerCreditDTO) && ((CustomerCreditDTO) o).id == id;
	}

	/**
	 * id
	 */
	public int hashCode() {
		return id;
	}

}
