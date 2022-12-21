package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재 예상 구매량 추정을 관리하는 ExpectPoQtyEst DAO
 * 
 * @ClassName ExpectPoQtyEstDAO.java
 * @Description ExpectPoQtyEstDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.11    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.07.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Repository("/rc/rrm/expectPoQtyEstDAO")
public class ExpectPoQtyEstDAO extends DefaultDAO
{
	/**
	 * 레시피 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.expectPoQtyEstDAO.selectList", mapParam);
	}

	/**
	 * 식재 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.expectPoQtyEstDAO.selectDetailList", mapParam);
	}

	/**
	 * 예상판매량을 저장한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveList(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.expectPoQtyEstDAO.saveList", mapParam);
	}

	/**
	 * 예상판매량을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteList(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.expectPoQtyEstDAO.deleteList", mapParam);
	}
}