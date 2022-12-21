package com.hwfs.fm.fmp.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmp.dao.WhPackModifyDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 창고일괄변경 ServiceImple Class
 *
 * @ClassName WhPackModifyServiceImple.java
 * @Description WhPackModifyServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 5.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 8. 5.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmp/whPackModifyService")
public class WhPackModifyServiceImpl extends DefaultServiceImpl implements WhPackModifyService {

    @Resource(name = "/fm/fmp/whPackModifyDAO")
    private WhPackModifyDAO whPackModifyDAO;

    /**
     * 창고일괄변경 목록을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.WhPackModifyService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		// CENTER_CODE 다중 처리 : 2016-01-11
    	parameter.put("schCode", inCode(parameter.get("schCode").toString()));
        return whPackModifyDAO.selectList(parameter);
    }

    /**
     * 일자를 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.WhPackModifyService#selectDdayList(java.util.Map)
    */
    @Override
    public RecordSet selectDdayList(Map<String, Object> parameter) throws Exception {
        return whPackModifyDAO.selectDdayList(parameter);
    }

    /**
     * 시간을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.WhPackModifyService#selectDtimesList(java.util.Map)
    */
    @Override
    public RecordSet selectDtimesList(Map<String, Object> parameter) throws Exception {
        return whPackModifyDAO.selectDtimesList(parameter);
    }

    /**
     * 창고별 일자 시간을 저장한다.
     *
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.WhPackModifyService#modifyList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> modifyList(DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "0";

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    procCnt += whPackModifyDAO.modifyList(parameter);
                }
            }
        }

        // 구매쪽 Procedure Call
        Map<String, Object> itemProcParam = new HashMap<String, Object>();
        Map<String, Object> retProcItemVal = new HashMap<String, Object>();
        itemProcParam.put("p_sys_id", "100");	// 시스템 아이디
        itemProcParam.put("p_comp_cd", "HFC"); // 회사코드
        retProcItemVal = whPackModifyDAO.modifyItemList(itemProcParam);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 창고별 일괄 일자 시간을 저장한다.
     *
     * @param param
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.WhPackModifyService#modifyAllList(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> modifyAllList(Map<String, Object> param, DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "0";

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    parameter.put("dDays", LimsUtil.checkNull(param.get("dDays")));
                    parameter.put("dTimes", LimsUtil.checkNull(param.get("dTimes")));
                    procCnt += whPackModifyDAO.modifyList(parameter);
                }
            }
        }

        // 구매쪽 Procedure Call
        Map<String, Object> itemProcParam = new HashMap<String, Object>();
        Map<String, Object> retProcItemVal = new HashMap<String, Object>();
        itemProcParam.put("p_sys_id", "100");	// 시스템 아이디
        itemProcParam.put("p_comp_cd", "HFC"); // 회사코드
        retProcItemVal = whPackModifyDAO.modifyItemList(itemProcParam);

        // 구매쪽에서 테이블을 읽어 건별로 처리하므로 Rollback을 시키면 안된다.
        // 프로시저에서 오류로 처리하는 경우는 창고가 없는경우 오류로 처리한다.
        //if (LimsUtil.checkNull(retProcItemVal.get("O_RTN_CD")).equals("E")) {
        //    throw new BizException(LimsUtil.checkNull(retProcItemVal.get("O_RTN_MSG")));
        //}

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

	/**
	 * 콤마 값을 IN 처리에 맞게 변경.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public String inCode(String schCode) throws Exception {
		
		if(schCode.indexOf(',') != -1){
			return "'"+schCode.replaceAll(",", "','")+"'";
		}else{
			return "'"+schCode+"'";
		}
	}    
    
}
