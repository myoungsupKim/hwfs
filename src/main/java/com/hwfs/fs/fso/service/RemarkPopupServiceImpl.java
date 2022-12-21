package com.hwfs.fs.fso.service;

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
import com.hwfs.fs.fso.dao.RemarkPopupDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 물건정보 특이사항 관리 ServiceImple Class
 *
 * @ClassName RemarkPopupServiceImple.java
 * @Description RemarkPopupServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.18.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.18.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/remarkPopupService")
public class RemarkPopupServiceImpl extends DefaultServiceImpl implements RemarkPopupService {

    @Resource(name = "/fs/fso/remarkPopupDAO")
    private RemarkPopupDAO remarkPopupDAO;
 
    /**
     * 물건정보 특이사항 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fs.fso.service.RemarkPopupService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return remarkPopupDAO.selectList(mapParam);
    }

    /**
     * 물건정보 특이사항 정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fs.fso.service.RemarkPopupService#saveList(java.util.Map)
    */
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += remarkPopupDAO.insert(rowData);
				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += remarkPopupDAO.update(rowData);

			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += remarkPopupDAO.delete(rowData);
				
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
    
}