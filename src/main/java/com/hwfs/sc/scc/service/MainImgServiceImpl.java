package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.cmn.util.IdGenUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.scc.dao.MainImgDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 메인화면 이미지를 관리하는 MainImg Service Implementation
 * 
 * @ClassName MainImgServiceImpl.java
 * @Description MainImgServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.23    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.12.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/mainImgService")
public class MainImgServiceImpl extends DefaultServiceImpl implements MainImgService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MainImgDAO Bean 생성 */
	@Resource(name = "/sc/scc/mainImgDAO")
	private MainImgDAO mainImgDAO;
	

	/**
	 * 메인화면 이미지 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return mainImgDAO.selectList(mapParam);
	}

	/**
	 * 메인화면 이미지 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		byte[] blob;
		String fileName = "";
		String appendFileName = "";
		String fileExt = "";
		String path = propertiesService.getString("global.imagerepository.path") + File.separator;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				LimsUtil.deleteFile(path + rowData.get("fileName").toString());
			}
			
			if (rowType != DataSet.ROW_TYPE_DELETED) {
				blob = (byte[])rowData.get("fileData");
				LimsUtil.makeFolder(path);
				
				fileName = UUIdGenUtil.getUUID();
				appendFileName = rowData.get("appendFileName").toString();
				fileExt = LimsUtil.getFileExt(appendFileName);
				
				LimsUtil.saveBlobToFile(path + fileName + "." + fileExt, blob);
				rowData.put("fileName", fileName + "." + fileExt);
			}
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += mainImgDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += mainImgDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += mainImgDAO.delete(rowData);
				LimsUtil.deleteFile(path + rowData.get("fileName").toString());
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
