package com.hwfs.rc.sle.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * CookMtodDAO에 대한 설명 작성
 * @ClassName CookMtodDAO.java
 * @Description CookMtodDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 8.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 4. 8.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/cookMtodMgmtDAO")
public class CookMtodMgmtDAO extends DefaultDAO {
	/**
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectGrpList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.cookMtodMgmtDAO.selectGrpList", parameter);
	}

	public RecordSet selectListGrpCheck(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.cookMtodMgmtDAO.selectListGrpCheck", parameter);
	}

	public RecordSet selectListCheck(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.cookMtodMgmtDAO.selectListCheck", parameter);
	}

		
	
 	 	
	/**
	 * insertData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertGrpData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.cookMtodMgmtDAO.insertGrpData", parameter);
	}
 
	/**
	 * updateData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateGrpData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.cookMtodMgmtDAO.updateGrpData", parameter);
	}
	
	/**
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.cookMtodMgmtDAO.selectList", parameter);
	}
	 	
 	 	
	/**
	 * insertData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.cookMtodMgmtDAO.insertData", parameter);
	}
 
	/**
	 * updateData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.cookMtodMgmtDAO.updateData", parameter);
	}


	/**
	 * 그룹코드의 사용상태가 [사용안함] 상태인 경우에는 전체 코드를 [사용안함] 상태로 변경한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateUseAllData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.cookMtodMgmtDAO.updateUseAllData", parameter);
	}
	
	/**
	 * maxCodeCreate  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public Record maxCodeCreate(Map<String, Object> parameter) {
		return super.queryForRecord("rc.sle.cookMtodMgmtDAO.maxCodeCreate",parameter);
	}
	
	public Record maxCodeCreateGrp(Map<String, Object> parameter) {
		return super.queryForRecord("rc.sle.cookMtodMgmtDAO.maxCodeCreateGrp",parameter);
	}
	
}
