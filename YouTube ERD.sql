CREATE TABLE IF NOT EXISTS user_profile (
    id BIGSERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE,
    gender TEXT CHECK (gender IN ('Male', 'Female')) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_account(
    user_profile_id BIGINT PRIMARY KEY REFERENCES user_profile(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS youtube_channel(
    id BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(user_profile_id),
    channel_name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS channel_subscriber (
    youtube_account_id BIGINT REFERENCES youtube_account(user_profile_id),
    youtube_channel_id BIGINT REFERENCES youtube_channel(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    PRIMARY KEY (youtube_account_id, youtube_channel_id)
);

CREATE TABLE IF NOT EXISTS video (
    id BIGSERIAL PRIMARY KEY,
    youtube_channel_id BIGINT NOT NULL REFERENCES youtube_channel(id),
    url TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    category TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_view (
    id BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT REFERENCES youtube_account(user_profile_id),
    video_id BIGINT NOT NULL REFERENCES video(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_like (
    youtube_account_id BIGINT REFERENCES youtube_account(user_profile_id),
    video_id BIGINT REFERENCES video(id),
    PRIMARY KEY(youtube_account_id, video_id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_comment (
    id BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(user_profile_id),
    video_id BIGINT NOT NULL REFERENCES video(id),
    comment TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TABLE IF NOT EXISTS video_comment_like (
  youtube_account_id BIGINT REFERENCES youtube_account(user_profile_id),
  video_comment_id BIGINT REFERENCES video_comment(id),
  PRIMARY KEY(youtube_account_id, video_comment_id),
  video_id BIGINT REFERENCES video(id),
  created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

-- INSERTs ------------------------------------------------------------------------------------------

-- users
INSERT INTO user_profile (id, first_name, last_name, email, gender, created_at) VALUES (1, 'Joma', 'Kora', 'joma@gmail.com', 'Male', '2021-07-28');
INSERT INTO user_profile (id, first_name, last_name, email, gender, created_at) VALUES (2, 'Hose', 'Jaika', 'hose@gmail.com', 'Male', '2021-05-15');
INSERT INTO user_profile (id, first_name, last_name, email, gender, created_at) VALUES (3, 'Lari', 'Muhammad', 'lari@gmail.com', 'Male', '2021-01-05');
INSERT INTO user_profile (id, first_name, last_name, email, gender, created_at) VALUES (4, 'Alex', 'Ohio', 'alex@gmail.com', 'Female', '2021-05-14');

INSERT INTO user_profile (id, first_name, last_name, email, gender, created_at) VALUES (5, 'Angela', 'Bill', 'tom@gmail.com', 'Female', '2021-05-14');

-- accounts
INSERT INTO youtube_account (user_profile_id, created_at) VALUES (1, '2021-07-29');
INSERT INTO youtube_account (user_profile_id, created_at) VALUES (3, '2021-01-06');
INSERT INTO youtube_account (user_profile_id, created_at) VALUES (4, '2021-05-15');

INSERT INTO youtube_account (user_profile_id, created_at) VALUES (5, '2021-11-19');

-- youtube_channels
INSERT INTO youtube_channel (id, youtube_account_id, channel_name, created_at) VALUES (1, 1, 'JomaTech', '2021-07-29');
INSERT INTO youtube_channel (id, youtube_account_id, channel_name, created_at) VALUES (2, 3, 'MuhammadMaths', '2021-01-06');
INSERT INTO youtube_channel (id, youtube_account_id, channel_name, created_at) VALUES (3, 4, 'OhioGaming', '2021-05-15');

INSERT INTO youtube_channel (id, youtube_account_id, channel_name, created_at) VALUES (4, 4, 'Alex_Travel', '2021-05-15'); -- Minus

-- subscribers
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at) VALUES (1, 2, '2019-08-15');
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at) VALUES (1, 3, '2020-10-29');
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at) VALUES (3, 1, '2021-09-17');
INSERT INTO channel_subscriber (youtube_account_id, youtube_channel_id, created_at) VALUES (4, 2, '2021-09-18');

-- videos
INSERT INTO video(id, youtube_channel_id, url, title, description, category, created_at) VALUES (1, 1, 'https://youtube.com/1234', 'How to hack NASA?!', 'In this video you will learn how to hack the NASA!', 'Technology', '2021-07-18'); -- It means that a YouTube channel 'JomaTech' (channel_id = 1) has a video called 'How to hack NASA?!' (video_id = 1)
INSERT INTO video(id, youtube_channel_id, url, title, description, category, created_at) VALUES (2, 1, 'https://youtube.com/12345', 'How to learn Python?', 'In this video you will learn about Python', 'Programming', '2021-07-19');
INSERT INTO video(id, youtube_channel_id, url, title, description, category, created_at) VALUES (3, 3, 'https://youtube.com/123456', 'How to be pro in CS:GO?', 'GS:GO pro skills will be taught in this video!', 'Gaming', '2021-04-02');
INSERT INTO video(id, youtube_channel_id, url, title, description, category, created_at) VALUES (4, 2, 'https://youtube.com/1234567', 'What is an Integral?', 'Learn Integrals with us!', 'Maths', '2021-01-16');

-- video view
INSERT INTO video_view(id, youtube_account_id, video_id, created_at) VALUES(1, 5, 1, '2021-07-19'); -- It means that Angela viewed video video_id = 1, which is 'How to hack NASA?!'
INSERT INTO video_view(id, youtube_account_id, video_id, created_at) VALUES(2, 1, 4, '2021-01-17');
INSERT INTO video_view(id, youtube_account_id, video_id, created_at) VALUES(3, 3, 2, '2021-07-18');

-- video like
INSERT INTO video_like(youtube_account_id, video_id, created_at) VALUES (1, 4, '2021-01-17');
INSERT INTO video_like(youtube_account_id, video_id, created_at) VALUES (3, 2, '2021-07-20');  -- It means that Lari liked video_id = 2, which is 'How to learn Python?'

-- video comment
INSERT INTO video_comment(id, youtube_account_id, video_id, comment, created_at) VALUES (1, 1, 4, 'Thank you very much! I now understand what is an Integral!', '2021-08-11'); -- It means that Joma (account_id = 1) commented on video (video_id = 4) that's about Integrals
INSERT INTO video_comment(id, youtube_account_id, video_id, comment, created_at) VALUES (2, 3, 2, 'Hmmm... It is not so detailed video about Python. I would probably watch other videos regarding Python.', '2021-07-18');
INSERT INTO video_comment(id, youtube_account_id, video_id, comment, created_at) VALUES (3, 1, 3, 'Nice video about CS:GO!', '2021-04-03');
INSERT INTO video_comment(id, youtube_account_id, video_id, comment, created_at) VALUES (4, 4, 1, 'Unbelievable, NASA one love!', '2021-07-19');
INSERT INTO video_comment(id, youtube_account_id, video_id, comment, created_at) VALUES (5, 4, 4, 'Integrals can be interesting!', '2021-07-19');

-- video comment_like
INSERT INTO video_comment_like(youtube_account_id, video_comment_id, video_id, created_at) VALUES (1, 5, 4,  '2021-07-23'); -- Joma (account_id = 1) liked a comment (comment_id = 5) of ALex (account_id = 4)
INSERT INTO video_comment_like(youtube_account_id, video_comment_id, video_id, created_at) VALUES (4, 1, 1, '2021-07-23'); -- ALex (account_id = 4) liked a comment (comment_id = 1) of Joma (account_id = 1)



-- SQL statements/queries (in order to test) -------------------------------------------------------------------------------------------------------------------------
SELECT * FROM user_profile;
SELECT * FROM youtube_account;
SELECT * FROM youtube_channel;
SELECT * FROM channel_subscriber;

SELECT * FROM video;
SELECT * FROM video_view;
SELECT * FROM video_like;
SELECT * FROM video_comment;
SELECT * FROM video_comment_like;

-- Join User Profile - Youtube Account - Youtube Channel - Youtube Channel Subscriber(s)
SELECT * FROM user_profile LEFT JOIN youtube_account ON user_profile.id = youtube_account.user_profile_id
LEFT JOIN channel_subscriber ON youtube_account.user_profile_id = channel_subscriber.youtube_account_id
LEFT JOIN youtube_channel ON youtube_channel.id = channel_subscriber.youtube_channel_id;

-- Join video - video_view
SELECT * FROM video LEFT JOIN video_view ON video.id = video_view.youtube_account_id;

-- Join video - video_comment
SELECT * FROM video LEFT JOIN video_comment ON video.id = video_comment.video_id;

--Join video - video_comment - video_comment_like
SELECT * FROM video LEFT JOIN video_comment ON video.id = video_comment.video_id
LEFT JOIN video_comment_like ON video_comment.id = video_comment_like.video_comment_id;









