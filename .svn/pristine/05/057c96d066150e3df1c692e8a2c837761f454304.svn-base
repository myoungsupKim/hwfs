package com.hwfs.rc.bms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * BasAmMgmtDAO에 대한 설명 작성
 * @ClassName BasAmMgmtDAO.java
 * @Description BasAmMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 9.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 2. 9.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/basAmMgmtDAO")
public class BasAmMgmtDAO extends DefaultDAO {
	/**
	 * selectCodeList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	 
	public RecordSet selectList(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.basAmMgmtDAO.selectAmList", parameter);
	}
	
	public RecordSet amEmpNoSearch(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.basAmMgmtDAO.amEmpNoSearch", parameter);
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
	public Record maxAmCodeCreate() {
		return super.queryForRecord("rc.bms.basAmMgmtDAO.maxAmCodeCreate","");
	}
	/**
	 * insertAmMgmt 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public int insertAmMgmt(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basAmMgmtDAO.insertAmMgmt", parameter);
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
	public int updateAmMgmt(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basAmMgmtDAO.updateAmMgmt", parameter);
	}
}
