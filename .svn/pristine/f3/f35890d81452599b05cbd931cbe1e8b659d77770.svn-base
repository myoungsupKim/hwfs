package com.hwfs.sm.saa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 사고업장관리하는 AccdUpjangMngt DAO
 *
 * @ClassName AccdUpjangMngtDAO.java
 * @Description AccdUpjangMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.22      최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.22
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/saa/accdUpjangMngtDAO")
public class AccdUpjangMngtDAO extends DefaultDAO {

    /**
     * 사고업장관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("sm.saa.accdUpjangMngtDAO.selectList", mapParam);
    }
    
    /**
     * 사고채권발생보고, 매출 미발생 사유보고에 데이터가 있는지 확인한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectAccdList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("sm.saa.accdUpjangMngtDAO.selectAccdList", mapParam);
    }

    /**
     * 사고업장관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertAccdCustMst(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdUpjangMngtDAO.insertAccdCustMst", mapParam);
    }

    /**
     * 사고업장관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateAccdCustMst(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdUpjangMngtDAO.updateAccdCustMst", mapParam);
    }

    /**
     * 사고업장관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteAccdCustMst(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdUpjangMngtDAO.deleteAccdCustMst", mapParam);
    }
}
