package com.hwfs.guide.sample.dto;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.hwfs.cmn.defaults.DefaultDTO;

/**
 * SampleDTO
 * @ClassName SampleDTO.java
 * @Description SampleDTO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 11. 4.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 11. 4.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SampleDTO extends DefaultDTO {

    private static final long serialVersionUID = 1L;

    /** Grid Check */
    private String chk;

    /** 아이디 */
    private String id;
    
    /** 이름 */
    private String name;
    
    /** 내용 */
    private String description;
    
    /** 사용여부 */
    private String useYn;
    
    /** 등록자 */
    private String regUser;

    /** 등록일 */
    private String regDate;

    /**첨부파일 참조일련번호 */
    private String seqRel;
    
    /** 전자서명참조일련번호 */
    private String seqEsign;
    
    /** No */    
    private int no;
    
    public String getId() {
        return id;
    }

	public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getRegUser() {
        return regUser;
    }

    public void setRegUser(String regUser) {
        this.regUser = regUser;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

	/**
	 * seqRel 얻기
	 *
	 * @return the seqRel
	 */
	public String getSeqRel() {
		return seqRel;
	}

	/**
	 * seqRel 설정
	 *
	 * @param seqRel the seqRel to set
	 */
	public void setSeqRel(String seqRel) {
		this.seqRel = seqRel;
	}

	/**
	 * seqEsign 얻기
	 *
	 * @return the seqEsign
	 */
	public String getSeqEsign() {
		return seqEsign;
	}

	/**
	 * seqEsign 설정
	 *
	 * @param seqEsign the seqEsign to set
	 */
	public void setSeqEsign(String seqEsign) {
		this.seqEsign = seqEsign;
	}

    /**
	 * no 얻기
	 *
	 * @return the no
	 */
	public int getNo() {
		return no;
	}

	/**
	 * no 설정
	 *
	 * @param no the no to set
	 */
	public void setNo(int no) {
		this.no = no;
	}

	/**
	 * chk 얻기
	 *
	 * @return the chk
	 */
	public String getChk() {
		return chk;
	}

	/**
	 * chk 설정
	 *
	 * @param chk the chk to set
	 */
	public void setChk(String chk) {
		this.chk = chk;
	}

	/**
	 * toString override
	 *
	 * @return
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return ToStringBuilder.reflectionToString(this);
	}
}
