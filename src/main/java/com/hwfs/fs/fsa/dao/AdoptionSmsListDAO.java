package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.cmn.service.PropertiesService;

 /**
 * 채용인력 sms발송하는 AdoptionSmsList DAO
 * 
 * @ClassName AdoptionSmsListDAO.java
 * @Description AdoptionSmsListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.15   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionSmsListDAO")
public class AdoptionSmsListDAO extends DefaultDAO {
	
	/** PropertyService DI */
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;
	
	/**
	 * 채용인력 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionSmsListDAO.selectList", mapParam);
	}
	public RecordSet selectSmslog(Map<String, Object> mapParam) throws Exception {
		if(isTest()){
			return super.queryForRecordSet("fs.fsa.adoptionSmsListDAO.selectSmslogTest", mapParam);
		}else{
			return super.queryForRecordSet("fs.fsa.adoptionSmsListDAO.selectSmslog", mapParam);
		}
		
	}

	
	/**
	 * SMS 발송로그를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSmsLog(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionSmsListDAO.insertSmsLog", mapParam);
	}
	
	/**
	 * EMS가 테스트 환경인지 여부인지 검사한다.
	 * <pre>
	 * - ems.test.env=true이면 테스트 테이블로 처리, 아니면 실제 환경으로 처리한다.
	 * </pre>
	 *
	 * @return
	 */
	private boolean isTest () {
		return propertiesService.getBoolean("ems.test.env", true);
	}
	
}
