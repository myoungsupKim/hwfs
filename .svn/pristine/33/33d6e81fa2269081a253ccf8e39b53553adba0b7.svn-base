package com.hwfs.fs.fsb.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장관리하는 UpjangPackMgnt DAO
 * 
 * @ClassName UpjangPackMgntDAO.java
 * @Description UpjangPackMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsb/upjangPackMgntDAO")
public class UpjangPackMgntDAO extends DefaultDAO {
	
	/**
	 * 직군Combo 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectJobCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectJobCode", mapParam);
	}
	
	/**
	 * 상세직군 Combo 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubJobCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectSubJobCode", mapParam);
	}
	
	/**
	 * 지역1 Combo 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectLocCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectLocCode", mapParam);
	}
	
	/**
	 * 지역2 Combo 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubLocCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectSubLocCode", mapParam);
	}
	
	/**
	 * 메뉴구분 Combo 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectFilterGubunCd2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectFilterGubunCd2", mapParam);
	}
	
	/**
	 * 인허가형태 코드목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPermissionType(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectPermissionType", mapParam);
	}
	
	/**
	 * 회계정보(Tab1)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAccountingInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectAccountingInfo", mapParam);
	}
	
	/**
	 * 회계정보_은행정보(Tab1)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBankList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectBankList", mapParam);
	}
	
	/**
	 * 부서History(Tab1)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDeptHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectDeptHistory", mapParam);
	}
	
	/**
	 * 운영현황(TAB2)_업체구비허가증 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRemainmealdtl(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectRemainmealdtl", mapParam);
	}
	
	/**
	 * 운영현황(TAB2)_대외비문서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDocList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectDocList", mapParam);
	}
	
	/**
	 * 기기보유현황(Tab2)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUtensilList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectUtensilList", mapParam);
	}
	
	/**
	 * 계약정보(TAB3) 총투자실적, 보증금잔액, 미상각잔액 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectInvAmt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectInvAmt", mapParam);
	}
	
	/**
	 * 계약정보(TAB3) 업장 대표식단가,식수 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRespMealList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectRespMealList", mapParam);
	}
	
	/**
	 * 고객사관리 현황(Tab4)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectCustList", mapParam);
	}
	
	/**
	 * 인원 현황_재직현황(Tab5)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMemberCount(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectMemberCount", mapParam);
	}
	
	/**
	 * 인원 현황_재직현황(Tab5)를(외식) 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMemberCount2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectMemberCount2", mapParam);
	}
	
	/**
	 * 상세 배송주소현황(Tab2)를(외식) 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetailAddr(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectDetailAddr", mapParam);
	}
	
	/**
	 * 인원 현황(Tab5)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMemberInfoList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectMemberInfoList", mapParam);
	}
	
	/**
	 * 인원 현황(Tab5)_점장History 를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectJikchakHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectJikchakHistory", mapParam);
	}
	
	/**
	 * 인원 현황(Tab5)_발령History 를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMemberHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectMemberHistory", mapParam);
	}
	
	/**
	 * 식단가현황(Tab6)_현황을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMpriceInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectMpriceInfo", mapParam);
	}
	
	/**
	 * 식단가현황(Tab6)_History을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMpriceHistory(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectMpriceHistory", mapParam);
	}
	
	/**
	 * 예산현황(TAB7) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBudgetInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectBudgetInfo", mapParam);
	}
	
	/**
	 * 임대/보증금 현황(TAB8) 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGuarantyAmtInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.upjangPackMgntDAO.selectGuarantyAmtInfo", mapParam);
	}
	
	/**
	 * 기기보유현황(TAB2) 현황목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUtensil(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertUtensil", mapParam);
	}
	
	/**
	 * 기기보유현황(TAB2) 현황목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUtensil(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateUtensil", mapParam);
	}
	
	/**
	 * 상세 배송주소(TAB2) 현황목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDetailAddr(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateDetailAddr", mapParam);
	}
	
	/**
	 * 기기보유현황(TAB2) 현황목록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUtensil(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.deleteUtensil", mapParam);
	}
	
	/**
	 * 기기보유현황(TAB2) 이력정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUtensilHistory(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertUtensilHistory", mapParam);
	}
	
	/**
	 * 고객사현황(TAB4) 현황목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertCustInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertCustInfo", mapParam);
	}
	
	/**
	 * 고객사현황(TAB4) 현황목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateCustInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateCustInfo", mapParam);
	}
	
	/**
	 * 고객사현황(TAB4) 현황목록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteCustInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.deleteCustInfo", mapParam);
	}
	
	/**
	 * 고객사현황(TAB4) 이력정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertCustInfoHistory(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertCustInfoHistory", mapParam);
	}
	
	/**
	 * 고객사현황(TAB4)_상세 현황목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertCustChgInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertCustChgInfo", mapParam);
	}
	
	/**
	 * 고객사현황(TAB4)_상세 현황목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateCustChgInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateCustChgInfo", mapParam);
	}
	
	/**
	 * 고객사현황(TAB4)_상세 이력정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertCustChgInfoHistory(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertCustChgInfoHistory", mapParam);
	}
	
	/**
	 * 식단가현황(TAB6) 현황목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMpriceInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertMpriceInfo", mapParam);
	}
	
	/**
	 * 식단가현황(TAB6) 현황목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateMpriceInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateMpriceInfo", mapParam);
	}
	
	/**
	 * 식단가현황(TAB6) 현황목록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMpriceInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.deleteMpriceInfo", mapParam);
	}
	
	/**
	 * 식단가현황(TAB6) 현황목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMpriceHistory(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertMpriceHistory", mapParam);
	}
	
	/**
	 * 식단가현황(TAB6) 저장시 레시피분류 자동등록처리 call Procedure
	 * 
	 * @param inParam IN Parameter
	 * @return 결과 Map
	 */
	public Map<String, Object> callFsaUpjangRecipeClassPro(Map<String, Object> inParam) throws Exception {

		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("P_UPJANG",    Types.INTEGER),
		    new SqlParameter("P_JOB_CD",    Types.VARCHAR),
		    new SqlParameter("P_SUB_JOB_CD",Types.VARCHAR),
		    new SqlParameter("P_CUSER",     Types.VARCHAR),
            new SqlOutParameter("O_RTN",    Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
		};

		String procedureName = "FSA_UPJANG_RECIPE_CLASS_PRO";
		
		// procedure 호출
		return callProcedure(procedureName, sqlParameter, inParam);
	}
	
	/**
	 * 업장관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateAccountingInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateAccountingInfo", mapParam);
	}
	
	/**
	 * 회계 개점일자, 회계 폐점일자 update
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateStupjang(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateStupjang", mapParam);
	}
	
	/**
	 * 업장관리 이력정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangCnangeHistory(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertUpjangCnangeHistory", mapParam);
	}
	
	/**
	 * 잔반관리 master 재등록하기 위해 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteRemainmeal(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.deleteRemainmeal", mapParam);
	}
	
	/**
	 * 잔반관리 master(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRemainmeal(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertRemainmeal", mapParam);
	}
	
	/**
	 * 잔반관리 master 이력정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRemainmealHistory(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertRemainmealHistory", mapParam);
	}
	
	/**
	 * 잔반관리 detail 재등록하기 위해 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteRemainmealDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.deleteRemainmealDtl", mapParam);
	}
	
	/**
	 * 잔반관리 detail(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRemainmealDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertRemainmealDtl", mapParam);
	}
	
	/**
	 * 레시피분류를 재등록하기 위해 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteFsaRecipeLink(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.deleteFsaRecipeLink", mapParam);
	}
	
	/**
	 * 잔반관리 detail 이력정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRemainmealDtlHistory(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertRemainmealDtlHistory", mapParam);
	}
	
	/**
	 * 업장관리 imgPath(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateImgfile(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateImgfile", mapParam);
	}
	
	/**
	 * (TAB3) 업장 대표식단가,식수 목록을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRespMealList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.insertRespMealList", mapParam);
	}
	
	/**
	 * (TAB3) 업장 대표식단가,식수 목록을 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateRespMealList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.updateRespMealList", mapParam);
	}
	
	/**
	 * (TAB3) 업장 대표식단가,식수 목록을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteRespMealList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsb.upjangPackMgntDAO.deleteRespMealList", mapParam);
	}
}
