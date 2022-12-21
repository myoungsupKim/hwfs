package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * MenuMgmtDAO에 대한 설명 작성
 * @ClassName MenuMgmtDAO.java
 * @Description MenuMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 27.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 3. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/menuMgmtDAO")
public class MenuMgmtDAO extends DefaultDAO {
	
	/**
	 * selectListItemPool 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectListItemPool(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.menuMgmtDAO.selectListItemPool", parameter);
	}
	 
	/**
	 * selectFsItemPool 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFsItemPool(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.menuMgmtDAO.selectFsItemPool", parameter);
	}

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
		return super.queryForRecordSet("rc.sle.menuMgmtDAO.selectList", parameter);
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
		return super.update("rc.sle.menuMgmtDAO.insertData", parameter);
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
		return super.update("rc.sle.menuMgmtDAO.updateData", parameter);
	}

	/**
	 * deleteData  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.menuMgmtDAO.deleteData", parameter);
	}

	/**
	 * itemPool 데이터를 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateItemData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.menuMgmtDAO.updateItemData", parameter);
	}

	/**
	 * itemPool 데이터를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteItemData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.menuMgmtDAO.deleteItemData", parameter);
	}

	/*
	 * 2015.12.07 추가 메뉴 테이블에 바코드 사용중인것 중 최초인것을 update한다.
	 */
	public int updateDataMenuBar(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.menuMgmtDAO.updateDataMenuBar", parameter);
	}
	
	//바코드에 관한 처리
	public RecordSet selectListBarCd(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.menuMgmtDAO.selectListBarCd", parameter);
	}
	public RecordSet searchBarCd(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.menuMgmtDAO.searchBarCd", parameter);
	}
	public int insertDataBarCd(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.menuMgmtDAO.insertDataBarCd", parameter);
	}
	public int updateDataBarCd(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.menuMgmtDAO.updateDataBarCd", parameter);
	}
	
	//2016.01.21 추가 바코드가 다른 메뉴에서 사용 안함을 하는 경우 신규 메뉴에 매칭을 못하느문제로 삭제 처리 한다.
	//수정시 바로 삭제 한다.
	public int deleteDataBarCd(Map<String, Object> parameter) {
	//if (parameter.size() <= 0) return 0;
	return super.update("rc.sle.menuMgmtDAO.deleteDataBarCd", parameter);
	}

	
	/**
	 * selectSaleBarList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSaleBarList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.menuMgmtDAO.selectSaleBarList", parameter);
	}
	
	/**
	 * deleteSaleBarList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteSaleBarList(Map<String, Object> parameter) {
		return super.update("rc.sle.menuMgmtDAO.deleteSaleBarList", parameter);
	}
	
	/**
	 * saveSaleBarList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int saveSaleBarList(Map<String, Object> parameter) {
		return super.update("rc.sle.menuMgmtDAO.saveSaleBarList", parameter);
	}
	
	
	
}
