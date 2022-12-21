package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식자재영업 판매단가 생성하는 FoodMaterialsSalePrice DAO
 * 
 * @ClassName FoodMaterialsSalePriceDAO.java
 * @Description FoodMaterialsSalePriceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/foodMaterialsSalePriceDAO")
public class FoodMaterialsSalePriceDAO extends DefaultDAO {
	
	/**
	 * 식자재영업 센터별 고객사 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectUpjang", mapParam);
	}

	/**
	 * 식자재영업 센터별 고객사 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjang2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectUpjang2", mapParam);
	}
	
	/**
	 * 식자재영업 고객사별 계약번호 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectContract(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectContract", mapParam);
	}

	/**
	 * 식자재영업 고객사별 구매자재를 조회한다.(팝업)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectItem", mapParam);
	}
	
	/**
	 * 식자재영업 추가된 자재에 대한 구매정보를 GET
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItemPo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectItemPo", mapParam);
	}

	
	/**
	 * 식자재영업 판매단가 생성 목록을 조회한다.(단가개시일 기준 조회)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectList", mapParam);
	}

	/**
	 * 식자재영업 판매단가 생성 목록을 조회한다.(계약번호 기준 조회)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectList2", mapParam);
	}

	/**
	 * 식자재영업 판매단가 생성 목록을 조회한다.(조회용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListView(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectListView", mapParam);
	}
	public RecordSet selectListView2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectListView2", mapParam);
	}
	
	/**
	 * 식자재영업 자재별 계약일자를 GET
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 계약일자(시작일)
	 * @exception Exception
	 */
	public String selectItemDate(Map<String, Object> mapParam) throws Exception {
		RecordSet rs;
		rs = (RecordSet) queryForRecordSet("fm.fms.foodMaterialsSalePriceDAO.selectItemDate", mapParam);

		if (rs == null || rs.size() < 1)
			return "";
		else {
			Map map = rs.get(0);
			return map.get("contractStart").toString();
		}
	}
	
	/**
	 * 판매단가 정보 건수를 조회한다
	 * @return 건수
	 * @exception Exception
	 */
	public int selectCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fms.foodMaterialsSalePriceDAO.selectCnt", mapParam);
	}
	
	/**
	 * 식자재영업 판매단가 생성(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.insert", mapParam);
	}

	
	/**
	 * 식자재영업 판매단가 생성(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert2(List<Map> list) throws Exception {
		return super.batchUpdate2 ("fm.fms.foodMaterialsSalePriceDAO.insert2", list);
	}
	
	/**
	 * 식자재영업 판매단가 생성(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int[] insert3(List<Map> list) throws Exception {
		return super.batchUpdate ("fm.fms.foodMaterialsSalePriceDAO.insert2", list);
	}
	
	/**
	 * 식자재영업 판매단가 생성(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.update", mapParam);
	}

	/**
	 * 식자재영업 판매단가 정보의 계약종료일(CONTRACT_END)를 UPDATE한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.updateDate", mapParam);
	}
	public int updateDateNon(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.updateDateNon", mapParam);
	}
	public int updateDate3(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.updateDate3", mapParam);
	}

	/**
	 * 식자재영업 판매단가 정보의 계약종료일(CONTRACT_END)를 UPDATE한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDate2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.updateDate2", mapParam);
	}
	
	
	/**
	 * 식자재영업 판매단가 정보의 처리결과를 UPDATE한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMsg(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.updateMsg", mapParam);
	}
	
	/**
	 * 식자재영업 판매단가 생성(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.delete", mapParam);
	}

	/**
	 * 식자재영업 판매단가 생성(을)를 모두 삭제한다.(계약번호 기준)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.deleteAll", mapParam);
	}
	
	/**
	 * 식자재영업 선택한 자재를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.deleteItem", mapParam);
	}

	/**
	 * 판매단가 정보를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteFsale(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.foodMaterialsSalePriceDAO.deleteFsale", mapParam);
	}
	
}
