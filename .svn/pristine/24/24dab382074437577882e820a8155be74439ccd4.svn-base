package com.hwfs.ls.cmn.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.dao.SlaTestDAO;
import com.hwfs.ls.cmn.util.LimsUtil;

import hone.core.util.record.RecordSet;

/**
 * Sla I/F Test ServiceImple Class
 *
 * @ClassName SlaTestServiceImpl.java
 * @Description SlaTestServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 07.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 07.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/cmn/slaTestService")
public class SlaTestServiceImpl extends DefaultServiceImpl implements SlaTestService {

    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    @Resource(name = "/ls/cmn/slaTestDAO")
    private SlaTestDAO slaTestDAO;

    public Map<String, Object> saveSlaTest(Map<String, Object> parameter) throws Exception {
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        //Map<String, Object> retProcIsrVal = new HashMap<String, Object>();

        // 마감테이블에 전송
        retProcVal = slaTestDAO.updateTestEndApprvSLA(parameter);
        logger.debug("*************** slaTest retVal P_RET_CODE value={}", retProcVal.get("P_RET_CODE"));
        logger.debug("*************** slaTest retVal P_RET_MSG value={}", retProcVal.get("P_RET_MSG"));
        logger.debug("*************** slaTest retVal P_RECEIPT_NUM value={}", retProcVal.get("P_RECEIPT_NUM"));
        // 일마감 procedure 호출
        //retProcIsrVal = slaTestDAO.updateTestEndApprvSLAISRC(parameter);

        if (LimsUtil.checkNull(retProcVal.get("P_RET_CODE")).equals("E")) {
            throw new BizException(LimsUtil.checkNull(retProcVal.get("P_RET_MSG")));
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("retVal", retProcVal.get("P_RET_MSG"));
        //retVal.put("retProcIsrVal", retProcIsrVal);

        return retVal;
    }

    public RecordSet faxTransferTest(Map<String, Object> parameter) throws Exception {
        return slaTestDAO.faxTransferTest(parameter);
    }

}
