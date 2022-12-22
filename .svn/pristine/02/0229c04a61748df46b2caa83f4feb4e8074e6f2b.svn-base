package com.hwfs.ma.map.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 
 * @ClassName ImprovTaskMgmtDAO.java
 * @Description ImprovTaskMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.01    안종남        최초생성
 * </pre>
 * @author 안종남
 * @since 2015.07.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ma/map/improvTaskMgmtDAO")
public class ImprovTaskMgmtDAO extends DefaultDAO {

	
	/**
     * 사업계획 계정정보
     *
     * @param parameter
     * @return
     */
    public RecordSet selectVerNm(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectVerNm", parameter);
    }
	
	
	/**
     * 사업부 정보
     *
     * @param parameter
     * @return
     */
    public RecordSet selectMuInfo(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMuInfo", parameter);
    }
	
	/**
     * 부서정보
     *
     * @param parameter
     * @return
     */
    public RecordSet selectDeptInfo(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectDeptInfo", parameter);
    }
	
	/**
     * 업장에 대한 사업부 정보
     *
     * @param parameter
     * @return
     */
    public RecordSet selectMuCdForUpjang(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMuCdForUpjang", parameter);
    }
	
	/**
     * 사번에 대한 업장 정보
     *
     * @param parameter
     * @return
     */
    public RecordSet selectUpjangForSabun(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectUpjangForSabun", parameter);
    }
	
    /**
     * 개선과제 메인코드(대중소)
     *
     * @param parameter
     * @return
     */
    public RecordSet selectMapImprovCodeMst(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMapImprovCodeMst", parameter);
    }
    
    /**
     * 개선과제 메인코드(대중소)
     *
     * @param parameter
     * @return
     */
    public RecordSet selectImprovCode(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectImprovCode", parameter);
    }
    
   /**
	 * 개선과제 메인코드(대중소) 추가한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertMapImprovCodeMst(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.insertMapImprovCodeMst", parameter);
	}
	
	/**
	 * 개선과제 메인코드(대중소) 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateMapImprovCodeMst(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.updateMapImprovCodeMst", parameter);
	}
	
	/**
	 * 개선과제 메인코드(대중소) 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteMapImprovCodeMst(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.deleteMapImprovCodeMst", parameter);
	}

	/**
	 * 개선과제 메인코드(대중소) 전체를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteMapImprovCodeMstAll(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.deleteMapImprovCodeMstAll", parameter);
	}

	
	/**
     * 개선과제 계정코드를 제외한 전체 정보 조회
     *
     * @param parameter
     * @return
     */
    public RecordSet selectMapImprovMgtMst(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMapImprovMgtMst", parameter);
    }
    

    
   /**
	 * 상세 개선과제 추가 
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertMapImprovMgtMst(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.insertMapImprovMgtMst", parameter);
	}
	
	/**
	 * 상세 개선과제 리비전 저장( 히스토리 기능 )
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertMapImprovMgtMstRev(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.insertMapImprovMgtMstRev", parameter);
	}
	
	/**
	 * 상세 개선과제 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateMapImprovMgtMst(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.updateMapImprovMgtMst", parameter);
	}
	
	/**
	 * 상세 개선과제 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteMapImprovMgtMst(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.deleteMapImprovMgtMst", parameter);
	}


	/**
	* 유관부서 지원사항 조회
	*
	* @param parameter
	* @return
	*/
	public RecordSet selectMapImprovSupportForEmpNo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMapImprovSupportForEmpNo", parameter);
	}
	
	/**
	* 유관부서 지원사항 조회
	*
	* @param parameter
	* @return
	*/
	public RecordSet selectMapImprovSupport(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMapImprovSupport", parameter);
	}
	
	
	
	/**
	* 유관부서 지원사항 추가한다.
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int insertMapImprovSupport(Map<String, Object> parameter) {
	return super.update("ma.map.improvTaskMgmtDAO.insertMapImprovSupport", parameter);
	}
	
	/**
	* 유관부서 지원사항 수정한다.
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int updateMapImprovSupport(Map<String, Object> parameter) {
	return super.update("ma.map.improvTaskMgmtDAO.updateMapImprovSupport", parameter);
	}
	
	/**
	* 유관부서 지원사항 삭제한다.
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int deleteMapImprovSupport(Map<String, Object> parameter) {
	return super.update("ma.map.improvTaskMgmtDAO.deleteMapImprovSupport", parameter);
	}
	
	/**
	* 계정정보 조회
	*
	* @param parameter
	* @return
	*/
	public RecordSet selectMapImprovPlDtl(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMapImprovPlDtl", parameter);
	}
	
	/**
	* 계정정보 합계 조회
	*
	* @param parameter
	* @return
	*/
	public RecordSet selectMapImprovPlDtlSum(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMapImprovPlDtlSum", parameter);
	}
	
	
	
	/**
	* 계정정보 추가한다.
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int insertMapImprovPlDtl(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.insertMapImprovPlDtl", parameter);
	}
	
	/**
	* 계정정보 수정한다.
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int updateMapImprovPlDtl(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.updateMapImprovPlDtl", parameter);
	}
	
	/**
	* 계정정보 삭제한다.
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int deleteMapImprovPlDtl(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.deleteMapImprovPlDtl", parameter);
	}
	
	/**
	* 계정정보 전체 삭제한다.
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int deleteAllMapImprovPlDtl(Map<String, Object> parameter) {
		return super.update("ma.map.improvTaskMgmtDAO.deleteAllMapImprovPlDtl", parameter);
	}
	

	
	/**
	* 계정정보 조회
	*
	* @param parameter
	* @return
	*/
	public RecordSet selectMapAcctCdInfo(Map<String, Object> parameter) throws Exception {
	return super.queryForRecordSet("ma.map.improvTaskMgmtDAO.selectMapAcctCdInfo", parameter);
	}
	
	
	
	/**
	* 계정정보 추가( 대체 )
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int insertMapAcctCdInfo(Map<String, Object> parameter) {
	return super.update("ma.map.improvTaskMgmtDAO.insertMapAcctCdInfo", parameter);
	}
	
	/**
	* 계정정보 수정( 대체 )
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int updateMapAcctCdInfo(Map<String, Object> parameter) {
	return super.update("ma.map.improvTaskMgmtDAO.updateMapAcctCdInfo", parameter);
	}
	
	/**
	* 계정정보 삭제( 대체 )
	* <pre>
	* 메소드 상세설명 작성(생략 가능)
	* </pre>
	*
	* @param parameter
	* @return
	*/
	public int deleteMapAcctCdInfo(Map<String, Object> parameter) {
	return super.update("ma.map.improvTaskMgmtDAO.deleteMapAcctCdInfo", parameter);
	}
	
}
