<%--
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/display/init.jsp" %>

<%
int status = (Integer)request.getAttribute(WebKeys.KNOWLEDGE_BASE_STATUS);

ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Article article = (Article)row.getObject();
%>

<liferay-ui:icon-menu cssClass="kb-article-action">
	<c:if test="<%= ArticlePermission.contains(permissionChecker, article, ActionKeys.UPDATE) %>">
		<liferay-portlet:renderURL var="editURL">
			<portlet:param name="jspPage" value="/display/edit_article.jsp" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="resourcePrimKey" value="<%= String.valueOf(article.getResourcePrimKey()) %>" />
			<portlet:param name="status" value="<%= String.valueOf(WorkflowConstants.STATUS_ANY) %>" />
		</liferay-portlet:renderURL>

		<liferay-ui:icon
			image="edit"
			method="get"
			url="<%= editURL %>"
		/>
	</c:if>

	<c:if test="<%= article.isRoot() && ArticlePermission.contains(permissionChecker, article, ActionKeys.PERMISSIONS) %>">
		<liferay-security:permissionsURL
			modelResource="<%= Article.class.getName() %>"
			modelResourceDescription="<%= article.getTitle() %>"
			resourcePrimKey="<%= String.valueOf(article.getResourcePrimKey()) %>"
			var="permissionsURL"
		/>

		<liferay-ui:icon
			image="permissions"
			method="get"
			url="<%= permissionsURL %>"
		/>
	</c:if>

	<c:if test="<%= article.isApproved() || !article.isFirstVersion() %>">
		<liferay-portlet:resourceURL id="articleRSS" var="articleRSSURL">
			<portlet:param name="resourcePrimKey" value="<%= String.valueOf(article.getResourcePrimKey()) %>" />
			<portlet:param name="rssDelta" value="<%= String.valueOf(rssDelta) %>" />
			<portlet:param name="rssDisplayStyle" value="<%= rssDisplayStyle %>" />
			<portlet:param name="rssFormat" value="<%= rssFormat %>" />
		</liferay-portlet:resourceURL>

		<liferay-ui:icon
			image="rss"
			method="get"
			target="_blank"
			url="<%= articleRSSURL %>"
		/>
	</c:if>

	<c:if test="<%= (article.isApproved() || !article.isFirstVersion()) && ArticlePermission.contains(permissionChecker, article, ActionKeys.SUBSCRIBE) %>">
		<c:choose>
			<c:when test="<%= SubscriptionLocalServiceUtil.isSubscribed(user.getCompanyId(), user.getUserId(), Article.class.getName(), article.getResourcePrimKey()) %>">
				<liferay-portlet:actionURL name="unsubscribeArticle" var="unsubscribeArticleURL">
					<portlet:param name="redirect" value="<%= currentURL %>" />
					<portlet:param name="resourcePrimKey" value="<%= String.valueOf(article.getResourcePrimKey()) %>" />
				</liferay-portlet:actionURL>

				<liferay-ui:icon
					image="unsubscribe"
					url="<%= unsubscribeArticleURL %>"
				/>
			</c:when>
			<c:otherwise>
				<liferay-portlet:actionURL name="subscribeArticle" var="subscribeArticleURL">
					<portlet:param name="redirect" value="<%= currentURL %>" />
					<portlet:param name="resourcePrimKey" value="<%= String.valueOf(article.getResourcePrimKey()) %>" />
				</liferay-portlet:actionURL>

				<liferay-ui:icon
					image="subscribe"
					url="<%= subscribeArticleURL %>"
				/>
			</c:otherwise>
		</c:choose>
	</c:if>

	<c:if test="<%= ArticlePermission.contains(permissionChecker, article, ActionKeys.MOVE) %>">
		<liferay-portlet:renderURL var="moveURL">
			<portlet:param name="jspPage" value="/display/move_article.jsp" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="resourcePrimKey" value="<%= String.valueOf(article.getResourcePrimKey()) %>" />
			<portlet:param name="status" value="<%= String.valueOf(status) %>" />
		</liferay-portlet:renderURL>

		<liferay-ui:icon
			image="forward"
			message="move"
			method="get"
			url="<%= moveURL %>"
		/>
	</c:if>

	<c:if test="<%= ArticlePermission.contains(permissionChecker, article, ActionKeys.DELETE) %>">
		<liferay-portlet:actionURL name="deleteArticle" var="deleteURL">
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="resourcePrimKey" value="<%= String.valueOf(article.getResourcePrimKey()) %>" />
		</liferay-portlet:actionURL>

		<liferay-ui:icon-delete
			url="<%= deleteURL %>"
		/>
	</c:if>
</liferay-ui:icon-menu>