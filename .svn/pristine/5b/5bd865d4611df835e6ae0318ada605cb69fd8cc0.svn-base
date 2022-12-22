package com.hwfs.sm.saa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 매출미발생사유 및 계획을 관리하는 SalsNonOccurReasonRept DAO
 * 
 * @ClassName SalsNonOccurReasonReptDAO.java
 * @Description SalsNonOccurReasonReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/saa/salsNonOccurReasonReptDAO")
public class SalsNonOccurReasonReptDAO extends DefaultDAO {
	
	/**
	 * 매출미발생사유 및 계획 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCustList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.saa.salsNonOccurReasonReptDAO.selectCustList", mapParam);
	}
	public RecordSet selectDamboList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.saa.salsNonOccurReasonReptDAO.selectDamboList", mapParam);
	}
	public RecordSet selectArNonoccurList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.saa.salsNonOccurReasonReptDAO.selectArNonoccurList", mapParam);
	}
	public RecordSet selectHdrDealDesc(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.salsNonOccurReasonReptDAO.selectHdrDealDesc", parameter);
    }
	public RecordSet selectDealDescList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.saa.salsNonOccurReasonReptDAO.selectDealDescList", mapParam);
	}
	public RecordSet selectHdrDealDescFs(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sm.saa.salsNonOccurReasonReptDAO.selectHdrDealDescFs", parameter);
	}
	public RecordSet selectDealDescListFs(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.saa.salsNonOccurReasonReptDAO.selectDealDescListFs", mapParam);
	}

	
	/**
	 * 담보를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateRealEstate(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.updateRealEstate", mapParam);
	}
	public int updateGuaranteeInsur(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.updateGuaranteeInsur", mapParam);
	}
	public int updateGuarantor(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.updateGuarantor", mapParam);
	}
	public int updateCashGuarantee(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.updateCashGuarantee", mapParam);
	}
	public int updatePledge(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.updatePledge", mapParam);
	}
	public int updateAccRcvAlnt(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.updateAccRcvAlnt", mapParam);
	}

	/**
	 * 매출미발생사유 및 계획(을)를 등록, 수정, 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertArNonoccur(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.insertArNonoccur", mapParam);
	}
	public int updateArNonoccur(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.updateArNonoccur", mapParam);
	}
	public int deleteArNonoccur(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.saa.salsNonOccurReasonReptDAO.deleteArNonoccur", mapParam);
	}
	
	

    /**
     * 전자결재정보를 Update 처리한다.
     * <pre>
     * - Instance ID와 결재진행상태 Update
     * </pre>
     *
     * @param parameter
     * @return
     */
    public int updateSign(Map<String, Object> parameter) throws Exception {
        return super.update("sm.saa.salsNonOccurReasonReptDAO.updateSign", parameter);
    }
}
