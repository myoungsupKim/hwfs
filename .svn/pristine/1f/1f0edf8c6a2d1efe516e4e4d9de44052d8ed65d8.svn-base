package com.hwfs.fs.fsl.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 세금계산서 선택하는 PublishYnPopup DAO
 * 
 * @ClassName PublishYnPopupDAO.java
 * @Description PublishYnPopupDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.30   	이지운        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 이지운
 * @since 2015.07.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsl/publishYnPopupDAO")
public class PublishYnPopupDAO extends DefaultDAO {
	
	/**
	 * 세금계산서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPublishYnList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsl.publishYnPopupDAO.selectPublishYnList", mapParam);
	}

}
