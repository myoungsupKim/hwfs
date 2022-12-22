package com.hwfs.ei.isa.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특판상품을 정산하는 FsspExact DAO
 * 
 * @ClassName FsspExactDAO.java
 * @Description FsspExactDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.07   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 특판담당 김재섭
 * @since 2015.12.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ei/isa/fsspExactDAO")
public class FsspExactDAO extends DefaultDAO {
	
	/**
	 * 정산내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectExact(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectExact", mapParam);
	}

	/**
	 * 주문내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectOrder(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectOrder", mapParam);
	}
	
	/**
	 * 승인내역(상세)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectVanDtl(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectVanDtl", mapParam);
	}
	
	/**
	 * 결제별 주문내역
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectSaleVan(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectSaleVan", mapParam);
	}
	
	/**
	 * 주문내역을 삭제한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateOrderCancel(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateOrderCancel", parameter);
	}

	/**
	 * 주문내역을 수정한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateOrderChange(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateOrderChange", parameter);
	}

	/**
	 * 주문내역의 VAN KEY를 갱신한다.
	 * 
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateOrderVanKey(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateOrderVanKey", parameter);
	}

	/**
	 * 결제 승인(마스터)를 추가한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertVanMaster(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertVanMaster", parameter);
	}

	/**
	 * 결제 승인(마스터)를 수정한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateVanMaster(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateVanMaster", parameter);
	}

	/**
	 * 결제 승인(디테일)을 추가한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertVanDetail(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertVanDetail", parameter);
	}

	/**
	 * 결제 승인(디테일)을 수정한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateVanDetail(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateVanDetail", parameter);
	}

	/**
	 * 결제 승인 주문내역을 추가한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertSaleVan(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertSaleVan", parameter);
	}

	/**
	 * 결제 승인 주문내역을 삭제한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int deleteSaleVan(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.deleteSaleVan", parameter);
	}

	/**
	 * 취소거래에 대응하는 승인거래건을 취소("C") 마크한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateActionMark(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateActionMark", parameter);
	}
	
	public int updateLineStatus(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateLineStatus", parameter);
	}
	
	
	public RecordSet selectExactTarget(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectExactTarget", mapParam);
	}	

	public RecordSet selectExactVan(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectExactVan", mapParam);
	}
	
	public RecordSet selectExactVanDtl(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectExactVanDtl", mapParam);
	}
	
	public Record selectPrintData1(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("ei.isa.fsspExactDAO.selectPrintData1", mapParam);
	}

	public Record selectPrintData2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("ei.isa.fsspExactDAO.selectPrintData2", mapParam);
	}
	
	public Record selectPrintData3(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("ei.isa.fsspExactDAO.selectPrintData3", mapParam);
	}
	
	public RecordSet selectCardRegiData(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectCardRegiData", mapParam);
	}
	
	/**
	 * Regi Hdr 등록여부
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectExistsRegiHdr(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.isa.fsspExactDAO.selectExistsRegiHdr", parameter);
	}
	
	/**
	 * Regi Hdr 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertRegiHdr(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertRegiHdr", parameter);
	}

	/**
	 * Regi Hdr 수정
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateRegiHdr(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateRegiHdr", parameter);
	}

	/**
	 * 영수증번호 가져오기
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectReceiptNo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.isa.fsspExactDAO.selectReceiptNo", parameter);
	}
	
	/**
	 * Regi Unit 등록여부
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectExistsRegiUnit(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.isa.fsspExactDAO.selectExistsRegiUnit", parameter);
	}
	
	/**
	 * Regi Unit 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertRegiUnit(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertRegiUnit", parameter);
	}

	/**
	 * Regi Unit 수정
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateRegiUnit(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateRegiUnit", parameter);
	}

	/**
	 * Regi Unit Card 등록여부
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public Record selectExistsRegiUnitCard(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("ei.isa.fsspExactDAO.selectExistsRegiUnitCard", parameter);
	}
	
	/**
	 * Regi Unit Card 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertRegiUnitCard(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertRegiUnitCard", parameter);
	}

	/**
	 * Regi Unit Card 수정
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int updateRegiUnitCard(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.updateRegiUnitCard", parameter);
	}

	/**
	 * Tran Info 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertTranInfo(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertTranInfo", parameter);
	}

	/**
	 * Tran Item 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertTranItems(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertTranItems", parameter);
	}

	/**
	 * Tran Node등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertTranNode(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertTranNode", parameter);
	}

	/**
	 * Tran Card 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertTranCard(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertTranCard", parameter);
	}

	/**
	 * Tran Cash 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertTranCash(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertTranCash", parameter);
	}

	/**
	 * Tran Emp 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertTranEmp(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertTranEmp", parameter);
	}

	/**
	 * Tran Team 등록
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	public int insertTranTeam(Map<String, Object> parameter) throws Exception {
		return super.update("ei.isa.fsspExactDAO.insertTranTeam", parameter);
	}

	/**
	 * Regi XML 작성용 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectRegiXML(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectRegiXML", mapParam);
	}
	
	/**
	 * Regi Card Data XML 작성용 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectRegiCardXML(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectRegiCardXML", mapParam);
	}
	
	/**
	 * Tran Hdr XML 작성용 조회
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectTranHdr(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectTranHdr", mapParam);
	}
	
	/**
	 * Trans Item 작성
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectTranItems(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectTranItems", mapParam);
	}
	
	/**
	 * Card Tender 정보
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectTranCard(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectTranCard", mapParam);
	}
	
	public RecordSet selectTranCash(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectTranCash", mapParam);
	}

	public RecordSet selectTranEmp(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectTranEmp", mapParam);
	}

	public RecordSet selectTranTeam(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspExactDAO.selectTranTeam", mapParam);
	}
}
