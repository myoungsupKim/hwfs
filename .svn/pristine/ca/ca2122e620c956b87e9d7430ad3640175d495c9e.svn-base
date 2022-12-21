package com.hwfs.ls.lsm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lsm.dao.IntergInqueryDAO;

/**
 * 통합목록 조회 ServiceImple Class
 *
 * @ClassName IntergInqueryServiceImple.java
 * @Description IntergInqueryServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 13.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 13.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lsm/intergInqueryService")
public class IntergInqueryServiceImpl extends DefaultServiceImpl implements IntergInqueryService {

    @Resource(name = "/ls/lsm/intergInqueryDAO")
    private IntergInqueryDAO intergInqueryDAO;

    /**
     * 통합목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.IntergInqueryService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        parameter.put("mgrpArr", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("mgrpArr")), "∮"));
        parameter.put("mclassArr", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("mclassArr")), "∮"));
        parameter.put("sclassArr", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("sclassArr")), "∮"));
        parameter.put("progressStatus", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("progressStatus")), "∮"));
        return intergInqueryDAO.selectList(parameter);
    }

    /**
     * 대분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.IntergInqueryService#selectMgrpList(java.util.Map)
    */
    @Override
    public RecordSet selectMgrpList(Map<String, Object> parameter) throws Exception {
        return intergInqueryDAO.selectMgrpList(parameter);
    }

    /**
     * 중분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.IntergInqueryService#selectMcalssList(java.util.Map)
    */
    @Override
    public RecordSet selectMcalssList(Map<String, Object> parameter) throws Exception {
        parameter.put("mgrpCd", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("mgrpCd")), "∮"));
        return intergInqueryDAO.selectMcalssList(parameter);
    }

    /**
     * 소분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.IntergInqueryService#selectSclassList(java.util.Map)
    */
    @Override
    public RecordSet selectSclassList(Map<String, Object> parameter) throws Exception {
        parameter.put("mgrpCd", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("mgrpCd")), "∮"));
        parameter.put("mcalssCd", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("mcalssCd")), "∮"));
        return intergInqueryDAO.selectSclassList(parameter);
    }

}
