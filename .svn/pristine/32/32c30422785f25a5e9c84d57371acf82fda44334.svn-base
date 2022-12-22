package com.hwfs.rc.bms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * BasCaterchMgmtDAO에 대한 설명 작성
 * @ClassName BasCaterchMgmtDAO.java
 * @Description BasCaterchMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 13.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/basCaterchMgmtDAO")
public class BasCaterchMgmtDAO extends DefaultDAO {
	/**
	 * selectCodeList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectCaterchList(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.basCaterchMgmtDAO.selectCaterchList", parameter);
	}
	/**
	 * selectCodeList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public Record maxCaterchCodeCreate(Map<String, Object> parameter) {
		return super.queryForRecord("rc.bms.basCaterchMgmtDAO.maxCaterchCodeCreate",parameter);
	}
	/**
	 * insertCaterchMgmt 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public int insertCaterchMgmt(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCaterchMgmtDAO.insertCaterchMgmt", parameter);
	}
	
	/**
	 * updateAmMgmt  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateCaterchMgmt(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCaterchMgmtDAO.updateCaterchMgmt", parameter);
	}
	
}
