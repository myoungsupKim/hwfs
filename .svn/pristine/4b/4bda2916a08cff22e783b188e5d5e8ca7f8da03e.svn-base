package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;
import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주문신청에 대한 자재변경하는 OrderRequestChange DAO
 * 
 * @ClassName OrderRequestChangeDAO.java
 * @Description OrderRequestChangeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.29   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/orderRequestChangeDAO")
public class OrderRequestChangeDAO extends DefaultDAO {
	/**
	 * 주문신청관련 대상/변경자재 목록을 조회한다.(팝업용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItemPop(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestChangeDAO.selectItemPop", mapParam);
	}
	public RecordSet selectItemPop2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestChangeDAO.selectItemPop2", mapParam);
	}

	/**
	 * 주문신청관련 자재변경 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestChangeDAO.selectList", mapParam);
	}
	
	
	/**
	 * 대상자재의 판매단가 및 신청정보를 조회한다
	 * @param mapParam
	 * @return
	 */
//	public RecordSet selectPrice(Map<String, Object> mapParam) throws Exception {
//		return super.queryForRecordSet("fm.fms.orderRequestChangeDAO.selectPrice", mapParam);
//	}

	public String selectPrice(Map<String, Object> mapParam) throws Exception {
		RecordSet rs;
		rs = (RecordSet) queryForRecordSet("fm.fmo.orderRequestChangeDAO.selectPrice", mapParam);

		if (rs == null || rs.size() < 1)
			return "0";
		else {
			Map map = rs.get(0);
			return map.get("salePrice").toString();
		}
	}

	
	public String selectPoPrice(Map<String, Object> mapParam) throws Exception {
		RecordSet rs;
		rs = (RecordSet) queryForRecordSet("fm.fmo.orderRequestChangeDAO.selectPoPrice", mapParam);

		if (rs == null || rs.size() < 1)
			return "0";
		else {
			Map map = rs.get(0);
			return map.get("poPrice").toString();
		}
	}

	
	
	public RecordSet selectId(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestChangeDAO.selectId", mapParam);
	}
	
	
	
	/**
	 * 주문신청관련 자재변경(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestChangeDAO.insert", mapParam);
	}

	/**
	 * 판매단가정보에 운영율, 운영단가를 업데이트 한다
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateOpPrice(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestChangeDAO.updateOpPrice", mapParam);
	}
	
	/**
	 * 주문신청관련 자재변경(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestChangeDAO.update", mapParam);
	}
	
	/**
	 * 주문신청관련 자재변경(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestChangeDAO.delete", mapParam);
	}
	
	/**
	 * 주문신청관련 자재변경(을)를 주문번호 생성 규칙에 따라 리스트를 조회한다. (업장,거래처,입고일)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPrGroup(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestChangeDAO.selectPrGroup", mapParam);
	}
	
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	/**
	 * 자재에 대한 과세구분을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMtrlsTxnClss(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestChangeDAO.selectMtrlsTxnClss", mapParam);
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
}
