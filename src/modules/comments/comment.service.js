const commentModel = require('./comment.model');
const notificationModel = require('../notification/notification.model');
const { emitToUser } = require('../../utils/socket');

const createComment = async (accountId, body) => {
    const userId = await commentModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    const postExists = await commentModel.checkPostExists(body.post_id);
    if (!postExists) {
        const error = new Error('Blog post not found');
        error.statusCode = 404;
        throw error;
    }

    const result = await commentModel.createComment({
        postId: body.post_id,
        userId: userId,
        content: body.content
    });

    const commentId = result.insertId;
    const comment = await commentModel.findById(commentId);

    // Send real-time notification to post author (skip if commenter = author)
    try {
        const postOwnerId = await notificationModel.getPostOwnerId(body.post_id);
        if (postOwnerId && postOwnerId !== userId) {
            const notification = await notificationModel.createNotification({
                receiverId: postOwnerId,
                senderId: userId,
                postId: body.post_id,
                commentId: commentId
            });
            if (notification) {
                emitToUser(postOwnerId, 'new_notification', notification);
            }
        }
    } catch (notifError) {
        // Notification failure should not break comment creation
        console.error('[Notification] Failed to create/emit notification:', notifError.message);
    }

    return comment;
};

const updateComment = async (accountId, id, body) => {
    const userId = await commentModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    const comment = await commentModel.findById(id);
    if (!comment) {
        const error = new Error('Comment not found');
        error.statusCode = 404;
        throw error;
    }

    // Check ownership
    if (comment.user_id !== userId) {
        const error = new Error('Access denied. You can only update your own comments.');
        error.statusCode = 403;
        throw error;
    }

    await commentModel.updateComment(id, body.content);
    return await commentModel.findById(id);
};

const getAllCommentsByPostId = async (postId) => {
    const postExists = await commentModel.checkPostExists(postId);
    if (!postExists) {
        const error = new Error('Blog post not found');
        error.statusCode = 404;
        throw error;
    }

    return await commentModel.getAllCommentsByPostId(postId);
};

const deleteComment = async (accountId, id) => {
    const userId = await commentModel.getUserIdByAccountId(accountId);
    if (!userId) {
        const error = new Error('User profile not found');
        error.statusCode = 404;
        throw error;
    }

    const comment = await commentModel.findById(id);
    if (!comment) {
        const error = new Error('Comment not found');
        error.statusCode = 404;
        throw error;
    }

    // Check ownership: comment author or blog post owner
    const postOwnerId = await notificationModel.getPostOwnerId(comment.post_id);
    if (comment.user_id !== userId && postOwnerId !== userId) {
        const error = new Error('Access denied. You can only delete your own comments or comments on your post.');
        error.statusCode = 403;
        throw error;
    }

    await commentModel.deleteComment(id);
};

module.exports = {
    createComment,
    updateComment,
    getAllCommentsByPostId,
    deleteComment
};
