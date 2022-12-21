package com.hwfs.ft.fsi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SAP 인터페이스하는 FtSapInterface DAO
 *
 * @ClassName FtSapInterfaceDAO.java
 * @Description FtSapInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.25   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.06.25
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fsi/ftSapInterfaceDAO")
public class FtSapInterfaceDAO extends DefaultDAO {

    /**
     * SAP 인터페이스 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.ftSapInterfaceDAO.selectList", mapParam);
    }

    /**
     * SAP 인터페이스(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.ftSapInterfaceDAO.insert", mapParam);
    }

    /**
     * SAP 인터페이스(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.ftSapInterfaceDAO.update", mapParam);
    }

    /**
     * SAP 인터페이스(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.ftSapInterfaceDAO.delete", mapParam);
    }


    /**
     * SAP 인터페이스 마스터 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSlipMst(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.ftSapInterfaceDAO.selectSlipMst", mapParam);
    }

    /**
     * SAP 인터페이스 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSlipList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.ftSapInterfaceDAO.selectSlipList", mapParam);
    }
    /**
     * SAP 인터페이스 전자결재 id(을)를 수정한다
     *
     * @param mapParam
     * @return
     */
    public int updateSignInstanceId(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.ftSapInterfaceDAO.updateSignInstanceId", mapParam);
    }
    
	/**
	 * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGwSlipList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ft.fsi.ftSapInterfaceDAO.selectGwSlipList", mapParam);
	}
	    
}
