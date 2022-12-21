package com.hwfs.rc.bms.dao;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * BsaCodeMgmtDAO에 대한 설명 작성
 * @ClassName BsaCodeMgmtDAO.java
 * @Description BsaCodeMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 6.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 6.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/bms/basCodeMgmtDAO")
public class BasCodeMgmtDAO extends DefaultDAO {
	
	/**
	 * selectGroupList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 */
	public RecordSet selectGroupList() {
		DataSetMap dsm = new DataSetMap();
		return super.queryForRecordSet("rc.bms.basCodeMgmtDAO.selectGroupList", dsm);
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
	public RecordSet selectCodeList(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.basCodeMgmtDAO.selectCodeList", parameter);
	}
	
	/**
	 * selectListSCC 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectListSCC(Map<String, Object> parameter) {
		return super.queryForRecordSet("rc.bms.basCodeMgmtDAO.selectListSCC", parameter);
	}
	
	
	
	/**
	 * insertGroupList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 */
	public int insertGroupList(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCodeMgmtDAO.insertGroupList", parameter);
	}
	
	/**
	 * updateGroupList  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateGroupList(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCodeMgmtDAO.updateGroupList", parameter);
	}

	/**
	 * insertCodeList 생성한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertCodeList(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCodeMgmtDAO.insertCodeList", parameter);
	}
	
	/**
	 * updateCodeList 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateCodeList(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCodeMgmtDAO.updateCodeList", parameter);
	}
	
	/**
	 * 그룹코드의 사용상태가 [사용안함] 상태인 경우에는 전체 공통코드를 [사용안함] 상태로 변경한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateUseAllCode(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.bms.basCodeMgmtDAO.updateUseAllCode", parameter);
	}
}
