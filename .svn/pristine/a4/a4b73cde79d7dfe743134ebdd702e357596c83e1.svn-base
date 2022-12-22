package com.hwfs.guide.sample.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.GuideEncDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 개인정보보호 항목에 대한 암복호 처리 및 마스킹 처리 샘플 Service Implementation
 * 
 * @ClassName GuideEncServiceImpl.java
 * @Description GuideEncServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.02.12.   kksoo        최초 생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/guideEncService")
public class GuideEncServiceImpl extends DefaultServiceImpl implements GuideEncService {
	
	/** GuideEnc DAO */
	@Resource(name="/guide/sample/guideEncDAO")
	private GuideEncDAO guideEncDAO;
	
	/**
	 * 개인정보보호 항목을 개인정보처리등급에 따라 마스크하여 조회한다.
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.template.service.GuideSampleService#selectList(java.util.Map)
	*/
	public RecordSet selectMaskList(Map<String, Object> parameter) throws Exception {
		return guideEncDAO.selectMaskList(parameter);
	}

	/**
	 * 비밀번호를 제외한 개인정보보호 항목을 입력을 위한 경우에는 복호화하여 조회한다.
	 * <pre>
	 * - 저장,삭제,입력등의 권한이 있는 경우는 비 마스킹 처리
	 * </pre>
	 *
	 * @param parameter
	 * @return
	*/
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		//(참고)권한에 따른 마스크 여부 정보를 ThreadLocal에 설정하여 hqml로 전달하여 처리하는 경우
		//int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//RequestContextUtil.put("maskAuth", maskAuth);

		//방법1)MaskAuth에 따라 1개의 SQL로 통합한 방식 (표준)	
		return guideEncDAO.selectMaskAuthList(parameter);
		

//		//방법2)MaskAuth에 따라 2개의 SQL로 분리하여 처리하는 방식 (비표준)		
//		RecordSet rs = null;
//		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
//		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
//		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
//			rs = guideEncDAO.selectMgmtMask(parameter);
//		}
//		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
//			rs = guideEncDAO.selectList(parameter);
//		}
//		return rs;
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 추가/변경/삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//추가를 수행합니다.
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insertRowCnt += guideEncDAO.insert(rowData);
			}
			//수정을 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updateRowCnt += guideEncDAO.update(rowData);
			}
			//삭제를 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				deleteRowCnt += guideEncDAO.delete(rowData);
			}
		}
				
		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}
}
