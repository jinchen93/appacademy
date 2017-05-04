const APIUtil = {
  followUser: id => (
    $.ajax({
      url: `/users/${id}/follow`,
      method: 'POST',
      dataType: 'JSON'
    })
  ),

  unfollowUser: id => (
    $.ajax({
      url: `/users/${id}/follow`,
      method: 'DELETE',
      dataType: 'JSON'
    })
  ),

  searchUsers: queryVal => (
    $.ajax({
      url: '/users/search',
      method: 'GET',
      data: { query: queryVal },
      dataType: 'JSON'
    })
  ),

  createTweet: data => (
    $.ajax({
      url: '/tweets',
      method: 'POST',
      data: data,
      dataType: 'JSON'
    })
  ),

  fetchTweets: maxCreatedAt => (
    $.ajax({
      url: '/feed',
      method: 'GET',
      data: {
        max_created_at: maxCreatedAt
      },
      dataType: 'JSON'
    })
  )

};

module.exports = APIUtil;
