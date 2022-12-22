package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.sc.cmn.dto.FaxDTO;

/**
 * Fax IF 테이블에 전송 요청 정보를 등록하거나 결과를 조회하는 DAO
 * @ClassName FaxDAO.java
 * @Description FaxDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 3.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 2. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/faxDAO")
public class FaxDAO extends DefaultDAO {

	/** PropertyService DI */
	@Resource(name = "propertiesService")
	protected PropertiesService propertiesService;

	/**
	 * Fax IF 테이블에서 전송내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		if (isTest())
			return super.queryForRecordSet("sc.cmn.faxDAO.selectListTest", mapParam);
		else
			//실제 환경의 로그 조회
			return super.queryForRecordSet("sc.cmn.faxDAO.selectList", mapParam);
	}

	/**
	 * Fax IF 테이블에 전송 요청 정보를 등록한다.
	 *
	 * @param faxDTO
	 * @return 처리건수
	 * @throws Exception
	 */
	public int insert(FaxDTO faxDTO) throws Exception {
		String queryId;
		if (isTest())
			queryId = "sc.cmn.faxDAO.insertTest";
		else
			queryId = "sc.cmn.faxDAO.insert";

		return super.update(queryId, faxDTO);
	}
	
	/**
	 * FAX가 테스트 환경인지 여부인지 검사한다.
	 * <pre>
	 * - fax.test.env=true이면 테스트 테이블로 처리, 아니면 실제 환경으로 처리한다.
	 * </pre>
	 *
	 * @return
	 */
	private boolean isTest () {
		return propertiesService.getBoolean("fax.test.env", true);
	}

}
