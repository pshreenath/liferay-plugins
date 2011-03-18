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
String tabs2 = ParamUtil.getString(request, "tabs2", "general");
String tabs3 = ParamUtil.getString(request, "tabs3", "article");
%>

<liferay-portlet:renderURL portletConfiguration="true" var="portletURL">
	<portlet:param name="tabs2" value="<%= tabs2 %>" />
	<portlet:param name="tabs3" value="<%= tabs3 %>" />
</liferay-portlet:renderURL>

<liferay-ui:tabs
	names="general,display-settings,rss"
	param="tabs2"
	url="<%= portletURL %>"
/>

<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />

<aui:form action="<%= configurationURL %>" method="post" name="fm">
	<aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />
	<aui:input name="tabs2" type="hidden" value="<%= tabs2 %>" />
	<aui:input name="tabs3" type="hidden" value="<%= tabs3 %>" />

	<aui:fieldset>
		<c:choose>
			<c:when test='<%= tabs2.equals("general") %>'>
				<div class="kb-field-wrapper">
					<aui:field-wrapper label="order-by">
						<aui:select inlineField="<%= true %>" label="" name="preferences--articlesOrderByCol--">
							<aui:option label="author" selected='<%= articlesOrderByCol.equals("user-name") %>' value="user-name" />
							<aui:option label="create-date" selected='<%= articlesOrderByCol.equals("create-date") %>' />
							<aui:option label="modified-date" selected='<%= articlesOrderByCol.equals("modified-date") %>' />
							<aui:option label="priority" selected='<%= articlesOrderByCol.equals("priority") %>' />
							<aui:option label="title" selected='<%= articlesOrderByCol.equals("title") %>' />
							<aui:option label="view-count" selected='<%= articlesOrderByCol.equals("view-count") %>' />
						</aui:select>

						<aui:select inlineField="<%= true %>" label="" name="preferences--articlesOrderByType--">
							<aui:option label="ascending" selected='<%= articlesOrderByType.equals("asc") %>' value="asc" />
							<aui:option label="descending" selected='<%= articlesOrderByType.equals("desc") %>' value="desc" />
						</aui:select>
					</aui:field-wrapper>
				</div>
			</c:when>
			<c:when test='<%= tabs2.equals("display-settings") %>'>
				<liferay-ui:tabs
					names="article,template"
					param="tabs3"
					url="<%= portletURL %>"
				/>

				<c:choose>
					<c:when test='<%= tabs3.equals("article") %>'>
						<aui:input label="enable-description" name="preferences--enableArticleDescription--" type="checkbox" value="<%= enableArticleDescription %>" />

						<aui:input label="enable-categories" name="preferences--enableArticleAssetCategories--" type="checkbox" value="<%= enableArticleAssetCategories %>" />

						<aui:input label="enable-tags" name="preferences--enableArticleAssetTags--" type="checkbox" value="<%= enableArticleAssetTags %>" />

						<aui:input label="enable-ratings" name="preferences--enableArticleRatings--" type="checkbox" value="<%= enableArticleRatings %>" />

						<aui:input label="enable-comments" name="preferences--enableArticleComments--" type="checkbox" value="<%= enableArticleComments %>" />

						<aui:input label="show-comments" name="preferences--showArticleComments--" type="checkbox" value="<%= showArticleComments %>" />
					</c:when>
					<c:when test='<%= tabs3.equals("template") %>'>
						<aui:input label="enable-description" name="preferences--enableTemplateDescription--" type="checkbox" value="<%= enableTemplateDescription %>" />

						<aui:input label="enable-comments" name="preferences--enableTemplateComments--" type="checkbox" value="<%= enableTemplateComments %>" />

						<aui:input label="show-comments" name="preferences--showTemplateComments--" type="checkbox" value="<%= showTemplateComments %>" />
					</c:when>
				</c:choose>
			</c:when>
			<c:when test='<%= tabs2.equals("rss") %>'>
				<aui:select label="maximum-items-to-display" name="preferences--rssDelta--">
					<aui:option label="1" selected="<%= rssDelta == 1 %>" />
					<aui:option label="2" selected="<%= rssDelta == 2 %>" />
					<aui:option label="3" selected="<%= rssDelta == 3 %>" />
					<aui:option label="4" selected="<%= rssDelta == 4 %>" />
					<aui:option label="5" selected="<%= rssDelta == 5 %>" />
					<aui:option label="10" selected="<%= rssDelta == 10 %>" />
					<aui:option label="15" selected="<%= rssDelta == 15 %>" />
					<aui:option label="20" selected="<%= rssDelta == 20 %>" />
					<aui:option label="25" selected="<%= rssDelta == 25 %>" />
					<aui:option label="30" selected="<%= rssDelta == 30 %>" />
					<aui:option label="40" selected="<%= rssDelta == 40 %>" />
					<aui:option label="50" selected="<%= rssDelta == 50 %>" />
					<aui:option label="60" selected="<%= rssDelta == 60 %>" />
					<aui:option label="70" selected="<%= rssDelta == 70 %>" />
					<aui:option label="80" selected="<%= rssDelta == 80 %>" />
					<aui:option label="90" selected="<%= rssDelta == 90 %>" />
					<aui:option label="100" selected="<%= rssDelta == 100 %>" />
				</aui:select>

				<aui:select label="display-style" name="preferences--rssDisplayStyle--">
					<aui:option label="<%= RSSUtil.DISPLAY_STYLE_FULL_CONTENT %>" selected="<%= rssDisplayStyle.equals(RSSUtil.DISPLAY_STYLE_FULL_CONTENT) %>" />
					<aui:option label="<%= RSSUtil.DISPLAY_STYLE_ABSTRACT %>" selected="<%= rssDisplayStyle.equals(RSSUtil.DISPLAY_STYLE_ABSTRACT) %>" />
					<aui:option label="<%= RSSUtil.DISPLAY_STYLE_TITLE %>" selected="<%= rssDisplayStyle.equals(RSSUtil.DISPLAY_STYLE_TITLE) %>" />
				</aui:select>

				<aui:select label="format" name="preferences--rssFormat--">
					<aui:option label="RSS 1.0" selected='<%= rssFormat.equals("rss10") %>' value="rss10" />
					<aui:option label="RSS 2.0" selected='<%= rssFormat.equals("rss20") %>' value="rss20" />
					<aui:option label="Atom 1.0" selected='<%= rssFormat.equals("atom10") %>' value="atom10" />
				</aui:select>
			</c:when>
		</c:choose>

		<aui:button-row cssClass="kb-submit-buttons">
			<aui:button type="submit" />
		</aui:button-row>
	</aui:fieldset>
</aui:form>