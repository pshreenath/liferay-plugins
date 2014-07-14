/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
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

package com.liferay.notifications.hook.service.impl;

import com.liferay.compat.portal.kernel.notifications.UserNotificationDefinition;
import com.liferay.notifications.util.NotificationsUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.util.PortletKeys;
import com.liferay.portlet.asset.AssetRendererFactoryRegistryUtil;
import com.liferay.portlet.asset.model.AssetRendererFactory;
import com.liferay.portlet.blogs.model.BlogsEntry;
import com.liferay.portlet.blogs.service.BlogsEntryLocalService;
import com.liferay.portlet.blogs.service.BlogsEntryLocalServiceWrapper;

/**
 * @author Lin Cui
 */
public class BlogsEntryLocalServiceImpl extends BlogsEntryLocalServiceWrapper {

	public BlogsEntryLocalServiceImpl(
		BlogsEntryLocalService blogsEntryLocalService) {

		super(blogsEntryLocalService);
	}

	@Override
	public BlogsEntry updateStatus(
			long userId, long entryId, int status,
			ServiceContext serviceContext)
		throws PortalException, SystemException {

		BlogsEntry blogsEntry = super.updateStatus(
			userId, entryId, status, serviceContext);

		int notificationType =
			UserNotificationDefinition.NOTIFICATION_TYPE_ADD_ENTRY;

		if (serviceContext.isCommandUpdate()) {
			notificationType =
				UserNotificationDefinition.NOTIFICATION_TYPE_UPDATE_ENTRY;
		}

		String entryURL = NotificationsUtil.getEntryURL(
			_assetRendererFactory.getAssetRenderer(blogsEntry.getEntryId()),
			serviceContext);

		NotificationsUtil.sendNotificationEvent(
			blogsEntry.getCompanyId(), _BLOGS_ENTRY_CLASS_NAME,
			blogsEntry.getGroupId(), _BLOGS_ENTRY_CLASS_NAME, PortletKeys.BLOGS,
			blogsEntry.getEntryId(), blogsEntry.getTitle(), entryURL,
			notificationType, userId);

		return blogsEntry;
	}

	protected AssetRendererFactory _assetRendererFactory =
		AssetRendererFactoryRegistryUtil.getAssetRendererFactoryByClassName(
			_BLOGS_ENTRY_CLASS_NAME);

	private static final String _BLOGS_ENTRY_CLASS_NAME =
		BlogsEntry.class.getName();

}