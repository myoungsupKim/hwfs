package com.hwfs.ms.mmb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.mmb.dao.MessageBoardDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 공지사항하는 MessageBoard Service Implementation
 * 
 * @ClassName MessageBoardServiceImpl.java
 * @Description MessageBoardServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mmb/messageBoardService")
public class MessageBoardServiceImpl extends DefaultServiceImpl implements MessageBoardService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MessageBoardDAO Bean 생성 */
	@Resource(name = "/ms/mmb/messageBoardDAO")
	private MessageBoardDAO messageBoardDAO;
	

	/**
	 * 공지사항조회 목록을 조회한다.
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
		
		RecordSet rs = messageBoardDAO.selectBoardMstList(mapParam);
		
		if ( "02".equals(mapParam.get("gubun").toString()) ) {
			mapParam.put("boardMst", rs.get(0).getString("boardMst"));
			return messageBoardDAO.selectList(mapParam);
		} else {
			
			if ( "관리자".equals(rs.get(0).getString("boardMst").toString()) ) {
				return messageBoardDAO.selectList2(mapParam);
	
			} else {
				mapParam.put("boardMst", rs.get(0).getString("boardMst"));
				return messageBoardDAO.selectList(mapParam);
			}
		}
	}
	
	/**
	 * 게시판 관리자 정보 조회.
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
	public RecordSet selectBoardMstList(Map<String, Object> mapParam) throws Exception {
		
		return messageBoardDAO.selectBoardMstList(mapParam);		
		
	}
	
	/**
	 * 공지사항 조회시 조회건수를 Insert/Update/Delete 처리한다.
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
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
		    updRowCnt += messageBoardDAO.updateReadCnt(rowData);
		    
		    updRowCnt += messageBoardDAO.updateUserReadYn(rowData);
		}
				
		return updRowCnt;
	}
	
}
