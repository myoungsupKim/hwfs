package com.hwfs.rc.sle.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * ItemPoolMgmtDAO에 대한 설명 작성
 * @ClassName ItemPoolMgmtDAO.java
 * @Description ItemPoolMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 17.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 3. 17.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/itemPoolMgmtDAO")
public class ItemPoolMgmtDAO extends DefaultDAO {
	/**
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.itemPoolMgmtDAO.selectList", parameter);
	}
	
	/**
	 * selectSameList 기능 설명(같은 아이템명인 건 검색)
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectSameList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.itemPoolMgmtDAO.selectSameList", parameter);
	}
	 	
	 	
	/**
	 * selectNewFmItem 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectNewFmItem(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.itemPoolMgmtDAO.selectNewFmItem", parameter);
	}

	/**
	 * insertData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public int insertData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.itemPoolMgmtDAO.insertData", parameter);
	}
	
	/**
	 * updateData  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.itemPoolMgmtDAO.updateData", parameter);
	}

	/**
	 * deleteData 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.itemPoolMgmtDAO.deleteData", parameter);
	}

	/**
	 * 메뉴정보 데이터를 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateMenuData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.itemPoolMgmtDAO.updateMenuData", parameter);
	}

	/**
	 * 메뉴정보 데이터를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteMenuData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.itemPoolMgmtDAO.deleteMenuData", parameter);
	}

	/**
	 * 바코드 데이터를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteDataBarCd(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.itemPoolMgmtDAO.deleteDataBarCd", parameter);
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
		return super.queryForRecord("rc.sle.itemPoolMgmtDAO.maxCodeCreate",parameter);
	}
	 
}
