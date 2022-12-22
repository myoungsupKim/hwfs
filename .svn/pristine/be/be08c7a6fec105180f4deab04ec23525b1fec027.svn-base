package com.hwfs.fs.fsc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.fs.fsc.dao.FSC00020E_PopupDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 위생점검 평가내용 관리 ServiceImple Class
 *
 * @ClassName RemarkPopupServiceImple.java
 * @Description RemarkPopupServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.03.06.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2019.03.06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsc/FSC00020E_PopupService")
public class FSC00020E_PopupServiceImpl extends DefaultServiceImpl implements FSC00020E_PopupService {

    @Resource(name = "/fs/fsc/FSC00020E_PopupDAO")
    private FSC00020E_PopupDAO FSC00020E_PopupDAO;
 
    /**
     * 위생점검 평가내용을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fs.fsc.service.FSC00020E_PopupService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return FSC00020E_PopupDAO.selectList(mapParam);
    }

    /**
     * 위생점검 평가내용을 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fs.fsc.service.FSC00020E_PopupService#saveList(java.util.Map)
    */
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += FSC00020E_PopupDAO.update(rowData);

			}
		}
				
		return updRowCnt;
	}
    
}