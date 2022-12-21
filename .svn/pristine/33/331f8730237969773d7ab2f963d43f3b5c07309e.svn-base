package com.hwfs.ms.mtm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ms.mtm.dao.TeamLeaderAppDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등)하는 TeamLeaderApp Service Implementation
 * 
 * @ClassName TeamLeaderAppServiceImpl.java
 * @Description TeamLeaderAppServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mtm/teamLeaderAppService")
public class TeamLeaderAppServiceImpl extends DefaultServiceImpl implements TeamLeaderAppService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TeamLeaderAppDAO Bean 생성 */
	@Resource(name = "/ms/mtm/teamLeaderAppDAO")
	private TeamLeaderAppDAO teamLeaderAppDAO;
	

	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 목록을 조회한다.
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
		
		String gubun = (String) mapParam.get("apprGubunType");
		
		logger.debug("gubun >>>>" +gubun);
		
		//추가마감승인경우
		if(gubun.equals("001")){
			return teamLeaderAppDAO.selectList001(mapParam);
		
		//마감취소승인경우	
		}else if(gubun.equals("002")){
			logger.debug("gubun222 >>>>" +gubun);
			return teamLeaderAppDAO.selectList002(mapParam);
		
		//케이터링_기기기물 승인인경우
		}else if(gubun.equals("003")){				
			return teamLeaderAppDAO.selectList003(mapParam);
			
		//이벤트_기기기물 승인인경우	
		}else if(gubun.equals("004")){
			return teamLeaderAppDAO.selectList004(mapParam);
			
		//식권폐기관리	
		}else if(gubun.equals("005")){			
			return teamLeaderAppDAO.selectList005(mapParam);
		
		//시험접수승인(LIMS)	
		}else if(gubun.equals("006")){			
			return teamLeaderAppDAO.selectList006(mapParam);
		}
		
		return null;		
		
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 목록을 조회한다.
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
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception {
		
		return teamLeaderAppDAO.selectDetailList006(mapParam);			
		
	}

	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, Map<String, Object> mapParam) throws Exception {
		int updRowCnt = 0;
		int delRowCnt = 0;
		int insRowCnt = 0;
		
		String gubun = null;
		String chkGubun = null;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			gubun = (String) mapParam.get("apprGubunType");
			chkGubun = (String) mapParam.get("chkGubun");			
			
			logger.debug("gubun >>>>" +gubun);
			logger.debug("chkGubun >>>>" +chkGubun);
			
			//추가마감승인경우
			if(gubun.equals("001")){
				RecordSet saveChk = teamLeaderAppDAO.saveChk001(rowData);
				
				String aprvYn = (String) saveChk.get(0).get("aprvYn");
				
				if(LimsUtil.checkNull(aprvYn).equals("Y")){
					
					throw processException("ms.mtm.saveAppChk", new Object[]{"",""}); //마감승인이 이미 되었습니다. 확인하여 주십시요.
					
				}else{
					
					updRowCnt += teamLeaderAppDAO.update001(rowData);
					
				}				
			
			//마감취소승인경우(취소신청팀장승인)	
			}else if(gubun.equals("002")){
				
				RecordSet saveChk = teamLeaderAppDAO.saveChk002(rowData);
				
				//String upjangNm = (String) rowData.get("upjangNm");
					
				String approvYn = null;
				
				if(chkGubun.equals("approv")){	
					approvYn = (String) saveChk.get(0).get("apprvGubun");
				}else if(chkGubun.equals("teamMst")){
					approvYn = (String) saveChk.get(0).get("teamMstCongubn");
				}
				
				//이미 승인건이 존재할 경우
				if(LimsUtil.checkNull(approvYn).equals("Y")){
					throw processException("ms.mtm.saveAppChk", new Object[]{"","\n","\n"}); //마감승인이 이미 되었습니다. 확인하여 주십시요.					
				}else{	
					//마스터 승인시
					if(chkGubun.equals("approv")){						
						updRowCnt += teamLeaderAppDAO.updateApprov002(rowData);
					//팀장 승인시	
					}else if(chkGubun.equals("teamMst")){						
						updRowCnt += teamLeaderAppDAO.updateTeamMst002(rowData);
						
						String clsGubn = (String) list.get(i).get("clsGubn");
						logger.debug("clsGubn  >>>>>>>" +clsGubn);
						if(clsGubn.equals("Y"))
						{
							//MAS_CLOSE_MGMT Delete처리
							delRowCnt += teamLeaderAppDAO.delete002(rowData);							
						}
						
					}	
					
					
					// 마감, 마감취소시 이력생성
					//insRowCnt += teamLeaderAppDAO.insertHst002(rowData);							
				}		
					
			//케이터링_기기기물 승인인경우
			}else if(gubun.equals("003")){				
				
				updRowCnt += teamLeaderAppDAO.update003(rowData);
				
			//이벤트_기기기물 승인인경우
			}else if(gubun.equals("004")){
				
				updRowCnt += teamLeaderAppDAO.update004(rowData);
				
			//식권폐기관리	
			}else if(gubun.equals("005")){
				RecordSet saveChk = teamLeaderAppDAO.saveChk005(rowData);
				
				String approvYn = null;
				
				if(chkGubun.equals("approv")){	
					approvYn = (String) saveChk.get(0).get("approvCongubn");
				}else if(chkGubun.equals("teamMst")){
					approvYn = (String) saveChk.get(0).get("teamMstCongubn");
				}
				
				//이미 승인건이 존재할 경우
				if(LimsUtil.checkNull(approvYn).equals("Y")){
					throw processException("ms.mtm.saveAppChk", new Object[]{"","\n","\n"}); //마감승인이 이미 되었습니다. 확인하여 주십시요.					
				}else{	
					//마스터 승인시
					if(chkGubun.equals("approv")){						
						updRowCnt += teamLeaderAppDAO.updateApprov005(rowData);
					//팀장 승인시	
					}else if(chkGubun.equals("teamMst")){						
						updRowCnt += teamLeaderAppDAO.updateTeamMst005(rowData);
					}
						
				}
						
			}			
			
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 각종팀장반려처리(추가발주, 취소신청팀장승인, LIMS등) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveReturnList(DataSetMap list, Map<String, Object> mapParam) throws Exception {
		int updRowCnt = 0;
		int delRowCnt = 0;
		int insRowCnt = 0;
		
		String gubun = null;
		String chkGubun = null;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			gubun = (String) mapParam.get("apprGubunType");
			chkGubun = (String) mapParam.get("chkGubun");			
						
			logger.debug("gubun >>>>" +gubun);
			
			//추가마감승인경우
			if(gubun.equals("001")){
				
				logger.debug("개발예정");
			//마감취소승인경우	
			}else if(gubun.equals("002")){
				
				logger.debug("개발예정");
			//케이터링_기기기물 승인인경우
			}else if(gubun.equals("003")){				
				
				updRowCnt += teamLeaderAppDAO.update003(rowData);
				
			//이벤트_기기기물 승인인경우
			}else if(gubun.equals("004")){
				
				updRowCnt += teamLeaderAppDAO.updateReturn004(rowData);
				
			//식권폐기관리	
			}else if(gubun.equals("005")){
			
			RecordSet saveChk = teamLeaderAppDAO.saveChk005(rowData);
			String approvYn = null;
			
			if(chkGubun.equals("approv")){	
				approvYn = (String) saveChk.get(0).get("approvReturnCongubn");
			}else if(chkGubun.equals("teamMst")){
				approvYn = (String) saveChk.get(0).get("teamMstReturnCongubn");
			}
			
				//이미 반려건이 존재할 경우
				if(LimsUtil.checkNull(approvYn).equals("Y")){
					throw processException("ms.mtm.ms.mtm.saveReturnChk", new Object[]{"","\n","\n"}); //마감승인이 이미 되었습니다. 확인하여 주십시요.					
				}else{	
					//마스터 반려시
					if(chkGubun.equals("approv")){		
						updRowCnt += teamLeaderAppDAO.updateApprovReturn005(rowData);
					//팀장 반려시
					}else if(chkGubun.equals("teamMst")){
						updRowCnt += teamLeaderAppDAO.updateTeamMstReturn005(rowData);
					}
				}
					
			}			
			
			
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 각종팀장승인(추가발주, 취소신청팀장승인, LIMS등) 목록을 조회한다.
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
	public RecordSet selectCount(Map<String, Object> mapParam) throws Exception {
		
		return teamLeaderAppDAO.selectCount001(mapParam);
		
	}
}
