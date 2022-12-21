package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 정산집계관리(일별/월별/년별)하는 FuneralAdjustSum DAO
 * 
 * @ClassName FuneralAdjustSumDAO.java
 * @Description FuneralAdjustSumDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralAdjustSumDAO")
public class FuneralAdjustSumDAO extends DefaultDAO {
	
	/**
	 * 정산집계관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFuneralAdjustSumList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralAdjustSumDAO.selectFuneralAdjustSumList", mapParam);
	}
}
