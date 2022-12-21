package com.hwfs.fs.fsc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 케터링 실적보고(행사실적)하는 CateringActRept DAO
 * 
 * @ClassName CateringActReptDAO.java
 * @Description CateringActReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17   	yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsc/cateringActReptDAO")
public class CateringActReptDAO extends DefaultDAO {
	
	/**
	 * 케터링 실적보고(행사실적) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsc.cateringActReptDAO.selectCeleList", mapParam);
	}
	
	/**
	 * 케터링 실적보고(조리인력 지원실적)  목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsc.cateringActReptDAO.selectCookHumanList", mapParam);
	}
	
}
