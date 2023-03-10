package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주문 엑셀업로드하는 OrderRequestUpload DAO
 * 
 * @ClassName OrderRequestUploadDAO.java
 * @Description OrderRequestUploadDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.13   	손형민        최초생성
 *  2021.07.27      DEV02     [PJT]주문채널통합
 *  2021.10.14		hye.jin94 휴먼푸드 발주 권한
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.10.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/orderRequestUploadDAO")
public class OrderRequestUploadDAO extends DefaultDAO {

	
	/**
	 * 주문 엑셀업로드 데이터를체크 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String excelPrNum(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmo.orderRequestUploadDAO.fmsSoPrTempNum", mapParam , null);
	}
	public String getprNum(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmo.orderRequestUploadDAO.getprNum", mapParam , null);
	}
	
	/**
	 * 주문 엑셀업로드 데이터를체크 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public List<Map> select(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.selectList", mapParam);
	}
	
	/**
	 * 주문 엑셀업로드 데이터를체크 한다.
	 * 소숫점 발주 통제 추가
	 * @param mapParam
	 * @return
	 */
	public List<Map> selectExcelList(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.selectExcelList", mapParam);
	}
	
	/**
	 * 리조트 업장 여부 체크
	 */
	public String selectHnrUpjangYn(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmo.orderRequestUploadDAO.selectHnrUpjangYn", mapParam , null);
	}
	
	/**
	 * 주문 엑셀업로드 데이터를체크 한다.
	 * [PJT]주문채널통합
	 * 
	 * @param mapParam
	 * @return
	 */
	public List<Map> selectBrand(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.selectBrandList", mapParam);
	}
	
	/**
	 * 주문 엑셀업로드 데이터를체크 한다.
	 * 모아담 주문 업로드
	 * 
	 * @param mapParam
	 * @return
	 */
	public List<Map> selectMoadam(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.selectMoadam", mapParam);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 SO_PR 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.insert2", mapParam);
	}
	public int insert2Brand(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.insert2Brand", mapParam);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 TEMP_BIZ_EXCEL에서 FMS_SO_PR_TEMP로 INSERT 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.insert", mapParam);
	}
	/* 식재영업_긴급(29) */
	public int insert29(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.insert29", mapParam);
	}
	/* 브랜드 */
	public int insertBrand(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.insertBrand", mapParam);
	}
	/* 모아담 */
	public int insertMoadam(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.insertMoadam", mapParam);
	}
	
	public int insertMoadam29(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.insertMoadam29", mapParam);
	}
	/**
	 * 주문 엑셀업로드(을)를 수정한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int[] update(List<Map> list) throws Exception {
		return super.batchUpdate("fm.fmo.orderRequestUploadDAO.update", list);
	}
	
	public int[] updateBrand(List<Map> list) throws Exception {
		return super.batchUpdate("fm.fmo.orderRequestUploadDAO.updateBrand", list);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 엑셀파일을 임시 테이블에 저장한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int[] tempInsert(List<Map> listParam) throws Exception {
		return super.batchUpdate("fm.fmo.orderRequestUploadDAO.tempInsert", listParam);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 엑셀파일을 임시 테이블에 저장한다.
	 * [PJT]주문채널통합
	 * 
	 * @param mapParam
	 * @return
	 */
	public int[] tempBrandInsert(List<Map> listParam) throws Exception {
		return super.batchUpdate("fm.fmo.orderRequestUploadDAO.tempBrandInsert", listParam);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 엑셀파일을 임시 테이블에 저장한다.
	 * Moadam 주문 인터페이스
	 * 
	 * @param mapParam
	 * @return
	 */
	public int[] tempMoadamInsert(List<Map> listParam) throws Exception {
		return super.batchUpdate("fm.fmo.orderRequestUploadDAO.tempMoadamInsert", listParam);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 엑셀파일을 임시 테이블에 센터,업장,BIZ_KEY를 저장한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public int tempUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.tempUpdate", mapParam);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 SO_PR에 등록된 데이터를 업장별로 조회한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGroup(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectGroup", mapParam);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 SO_PR에 등록된 데이터를 업장별로 조회한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSopr(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectSopr", mapParam);
	}
	/* 브랜드 */
	public RecordSet selectSoprBrand(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectSoprBrand", mapParam);
	}
	
	
	
	/**
	 * 구매 I/F를 호출 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_if_sales_order(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("I_SYS_ID",      	Types.VARCHAR),
            new SqlParameter("I_COMP_CD",      	Types.VARCHAR),
            new SqlParameter("I_REQ_SYS_CD",    Types.VARCHAR),
            new SqlParameter("I_PURC_TYP_CD",   Types.VARCHAR),
            new SqlParameter("I_SHOP_CD",       Types.VARCHAR),
            new SqlParameter("I_REQ_USR_ID",    Types.VARCHAR),
            new SqlParameter("I_REQ_TYP_CD",    Types.VARCHAR),
            new SqlParameter("I_REQ_NO",        Types.VARCHAR),
            new SqlParameter("I_REQ_CLS",       Types.VARCHAR),
            new SqlOutParameter("O_RTN_CD",  	Types.VARCHAR),
            new SqlOutParameter("O_RTN_MSG",   	Types.VARCHAR)
        };
        /*
        - I_SYS_ID      IN VARCHAR2  : 시스템 아이디 ('100')
        - I_COMP_CD     IN VARCHAR2  : 회사 코드 ('HFC')
        - I_REQ_SYS_CD  IN VARCHAR2  : 신청 시스템 코드 [PR: 전사구매, FR: 통합영업, WR: WMS]
        - I_PURC_TYP_CD IN VARCHAR2  : 신청 시스템 구매유형 코드[MT:식자재, CT:상품, BT:일반자재(소모품),ST:일반자재(저장품),JT:일반자재(고정자산)]
        - I_SHOP_CD     IN VARCHAR2  : 신청업장 코드
        - I_REQ_USR_ID  IN VARCHAR2  : 신청자 아이디
        - I_REQ_TYP_CD  IN VARCHAR2  : 통합영업 S/O 유형코드(07,29)
        - I_REQ_NO      IN VARCHAR2  : Sales Order 요청 번호(PR_NUM)
        - I_REQ_CLS     IN VARCHAR2  : 요청 상태 [C-신규, U-수정, D-삭제]
        - O_RTN_CD     OUT VARCHAR2  : 처리 결과 코드 [S000: 정상, E901~E999: 에러]
        - O_RTN_MSG    OUT VARCHAR2  : 처리 결과 에러 메세지
         */
        String procedureName = "SP_IF_SALES_ORDER";
        // procedure 호출
        return callProcedure("EPROCUSR", null, procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 주문번호 생성 규칙에 따라 PR_NUM을 업데이트한다. (업장,입고일)
	 *
	 * @param mapParam
	 * @return
	 */
	public int prNumUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.prNumUpdate", mapParam);
	}
	
	
	/**
	 * 여신체크할 업장 정보를 조회 한다.(업장,입고일)
	 *
	 * @param mapParam
	 * @return
	 */
	public List<Map> upjangGroup(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.upjangGroup", mapParam);
	}
	
	/**
	 * 여신체크할 업장 정보를 조회 한다.(업장,입고일)
	 *
	 * @param mapParam
	 * @return
	 */
	public List<Map> upjangGroupTest(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.upjangGroupTest", mapParam);
	}

	/**
	 * 업장별 여신 잔액을 조회 해 온다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> selectCreInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.selectCreInfo", mapParam).get(0);
	}
	
	/**
	 * 업장별 여신 잔액을 조회 해 온다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> selectCreInfoTest(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.selectCreInfoTest", mapParam).get(0);
	}
	
	/**
	 * 업장별 여신 잔액 초과 업장 표시.
	 *
	 * @param mapParam
	 * @return
	 */
	/* 단일업장 대상 기준 */
	public int updateCreInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.updateCreInfo", mapParam);
	}
	/* 본사통합업장 대상 기준 */
	public int updateCreInfo2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.updateCreInfo2", mapParam);
	}
	
	/**
	 * 최종 발주일자를 조회한다.[여신체크] ---- 본사통합용(0)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectNeedDate(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectNeedDate", mapParam);
	}

	/**
	 * 최종 발주일자를 조회한다.[여신체크] ---- 본사통합용(X)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectNeedDate2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectNeedDate2", mapParam);
	}
	
	
	
	/**
	 *  (구매 IF 결과 UPDATE)
	 *
	 * @param mapParam
	 * @return
	 */
	public int prNumUpdateIF(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.prNumUpdateIF", mapParam);
	}
	
	/**
	 * TEMP_BIZ_EXCEL 
	 *
	 * @param mapParam
	 * @return
	 */
	public int tempDel(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.tempDel", mapParam);
	}
	public int tempDelExcel(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.tempDelExcel", mapParam);
	}
	
	/**
	 * TEMP_BIZ_EXCEL 
	 *
	 * @param mapParam
	 * @return
	 */
	public int tempDelfms(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestUploadDAO.tempDelfms", mapParam);
	}
	
	public RecordSet selectSISSubinvCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectSISSubinvCode", mapParam);
	}
	
	public RecordSet selectSISItemCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectSISItemCode", mapParam);
	}
	
	/** 
	 * SO_PR 등록된 모아담 발주 리스트 업데이트
	 *
	 */
	public int[] updateMoadam(List<Map> list) throws Exception {
		return super.batchUpdate("fm.fmo.orderRequestUploadDAO.updateMoadam", list);
	}

	/**
	 * 휴먼푸드 발주정보 권한을 조회한다.
	 * 추가일자:20211008  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHumanAuth(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectHumanAuth", mapParam);
	}
	
	/**
	 * 모아담 업장리스트를 조회한다.
	 * 추가일자:20220630  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet searchMoadamUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.searchMoadamUpjang", mapParam);
	}
	
	/**
	 * 허브메카 id를 조회한다.
	 * 추가일자:20220701  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet searchHubId(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.searchHubId", mapParam);
	}
	
	/**
	 * 허브메카 id를 전체조회한다.
	 * 추가일자:20220712  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet searchHubIdAll(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.searchHubIdAll", mapParam);
	}
	
	/**
	 * 휴먼푸드 발주 내역을 조회한다.
	 * 추가일자:20211025  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMoadamList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectMoadamList", mapParam);
	}
	
	/**
	 * 허브메카 발주 내역을 조회한다.
	 * 추가일자:20220607  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHubmekaList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectHubmekaList", mapParam);
	}
	
	/**
	 * 허브메카 발주 내역 (긴급)을 조회한다.
	 * 추가일자:20220607  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHubmekaList29(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectHubmekaList29", mapParam);
	}
	
	/**
	 * 주문 엑셀업로드(을)를 엑셀파일을 임시 테이블에 저장한다.
	 * Hubmeka 주문 인터페이스
	 * 
	 * @param mapParam
	 * @return
	 */
	public int[] tempHubmekaInsert(List<Map> listParam) throws Exception {
		return super.batchUpdate("fm.fmo.orderRequestUploadDAO.tempHubmekaInsert", listParam);
	}
	
	/**
	 * 주문 엑셀업로드 데이터를체크 한다.
	 * 허브메카 주문 업로드
	 * 
	 * @param mapParam
	 * @return
	 */
	public List<Map> selectHubmeka(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestUploadDAO.selectHubmeka", mapParam);
	}
	
	/** 
	 * SO_PR 등록된 허브메카 발주 리스트 업데이트
	 *
	 */
	public int[] updateHubmeka(List<Map> list) throws Exception {
		return super.batchUpdate("fm.fmo.orderRequestUploadDAO.updateHubmeka", list);
	}
	
	/**
	 * 허브메카 발주정보 권한을 조회한다.
	 * 추가일자:20220615  처리자:김혜진  
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHubAuth(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestUploadDAO.selectHubAuth", mapParam);
	}
	
}
