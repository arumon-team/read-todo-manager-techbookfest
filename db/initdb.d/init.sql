/*
積読本管理アプリケーション用データベース初期化スクリプト
*/

USE tsundoku_db;

-- DDL（Data Definition Language）セクション開始
-- テーブル構造の定義

-- ユーザーテーブルの作成
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 積読本テーブルの作成
    CREATE TABLE Books (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id VARCHAR(50) NOT NULL,
        title VARCHAR(255) NOT NULL,
        image TEXT,
        author VARCHAR(100),
        start_date DATE,
        finish_date DATE,
        days_per_week VARCHAR(5),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- -- メモテーブルの作成
CREATE TABLE Memos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    content VARCHAR(300),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- -- セッションテーブルの作成
CREATE TABLE Session (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    token VARCHAR(255) NOT NULL,
    expired_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- DDL セクション終了

-- DML（Data Manipulation Language）セクション開始
-- サンプルデータの挿入

-- ユーザーデータの挿入
INSERT INTO Users (user_id, password) VALUES 
('test_user', 'cGFzc3dvcmQ='); -- 左記はハッシュ化されたパスワード。実際にログインする時のパスワードには 'password'を使用

-- 書籍データの挿入
INSERT INTO Books (user_id, title, author, image, days_per_week, start_date, finish_date) VALUES 
("test_user", '1984', 'George Orwell', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAAEsCAYAAAB5fY51AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAB5BJREFUeNrs3YFx00gUBmBxcwWYCnAHZEgBMRXEHeCrIKGCOBVAOjAdmAowBYQxHZgKcAecljwd5oCJndjalfV9MxqFGYdIz3p/1tZ6U1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAI/3RAm66cXp6Um9G2zx0NWn29tVT2oyrHfDLR66rmuydBUJLPYbSKn50v55hNO2DfnH8NrYvtTbMgJt2cGaPNuoxz5qsq63z12ricAiVyOm7Sz2JxkOYxHNmpp2kXtUFqOlUYT1SXzdtmVsH9NeiAmsvgZU04wpoMZbvrRr2ypCLDXrvG7W9YFrMohanEVthgXWJNVgHjVZ9OWltsDqb0ilhnyVaQS1j9HGuwivlZocpiYILCF1uEad7TryipHU5IhrIrwEVueCqgmpcQ9Od5YatW7SxRY1OY+wOnbzqMlcNwisUkMqjRwuI6iGPSxBGlXcbI66NkZTFz2uSRp1vT30e4ACi11e9l1lGDms42XIfUYZjmsWX6eatH1DYVFgTZqR6LWXiwLrmINqUf08Z+p7SD3kt3WMdprJps08plxTKB6jmWpwqJoMDxxogktgtR5W6eL+sOfRwyoCqpkHtWzxfEbVj3lgo6qcaRbr6sfUiuV975Md4DlOtXhe7X+aRTqvl+Z1Cay2LuYPe/ot3MzpKerO0kaznmd4+ZRC6X3bob3liLqZJ7aPmynp/F7qJoHVxsX77ZEh9b5qYTLmns61mdB5Xh3urmcva1Kfq/4TWEUGVhop3HSlIe9p1Em1nzlUD57LVWh4XexaE4ElsEoKrOZjHDfH+F5FvO/1qtr9psOs2mLeVkdrchLBtdXHrQSWwColsK6rnsy92Zh/dqUmu9VEYAmsIgKrjxeimqhJG/5SAkBgAQgsQGABCCwAgQUILACBBSCwAIEFILAABBYgsAAEFoDAAgQWgMACEFjAEflbCfKJtb/fVO3/mfttpPXXX2eqS6rJZYE1mdXb6z6sS2+Exe+UGlbJZR0c0wxhNS00rKp4rq5ctgKrr8aFH99ZT37mrqGFwAIQWCW7Kfz4PvbkZ+5i5rIVWL306fZ2Wu/eVnd/Jbok6Xiu4/hy1OS60JpkuxHBHXcJ84dWagBN8GtoTVUCIyxAYAEILACBBQgsAIEFCCwAgQUgsACBBSCwAAQWILAAimS1hswKXb88LaUyy7ym+6TeBoXVxfIyRljCqsBDS0GRe033QYF1uYznDIHVS5PCj8+a7t17zgQWgMBiVvjxWdO9e8+ZwOIw4g3ctwUeWrN++TRDTaZVmevcV5U33bNzl7CM0NIEaoIRFiCwAAQWgMACBBaAwAIQWIDAAhBYAAILEFgAAgsQWEoAdIXVGjIrdP3ytLTLTY7lZaIm6edeFFiTmeVljLD6HlYlrl+ejucq45ruV4XWJMs69wisUkwKPz5ruv/qwmUrsAAEVuFmhR+fNd2795wJLA7muuAGyL2me6lhde2yzcddwozq5kx3nv6JjR91saY7RliAwAIQWAACCxBYAAILQGABAgtAYAECC0BgAQgsQGABCCwAgQUILACBBfBQVhztiBenp8N6N4x/jnb89rSy6TK+Xn26vV0dYU1Oqt3/NNji2GoisGi7CUfRfM9iv9mU+/oZ35s0thRkX9K+btpFz2py1dWaCCxyjRBSM55FI560+OObph/9r2mXMfL4nPZtjzwKrknaPuaoCQIrV0ANohnOYz8s8DB/Con6mFNzzlOz1o06P1Bdxh2pyWSjJinU30eArV3dAuvYRlGpIccdPIV0/JfV3Z9pryK8UqPOH9qoEdzjjtdkshFgj64J23miBA9quG/3PORpxxtyW98btW7S2X01qR/zpH7MpC81if3X+2qimwRWCYGVfssOelSSbc5XTQTWo5mHdRgD56sm2mD/vIfVLYvYr6q72+7beh4NlLaTI6vJMkYzafu8w/elKRLDI62JwKL1YFpGA6ZwWu7zzdx407u589XMbRp1pCZfYn+omgwj4LtQk97xGvphF/e3Pf5362jGZo7PMuN5NU16FvtcL2t6URPvYQmsrgRWasB3uZtxy2Zt7nYe+mVTqkMzNaD0mqTgevXYmggsgVVyYDUhNe/iTOmYTzbeR6OqicASWO1eqF+3fGmwioacHdPHOaJRL6JZhzt+e6pDmqN0c4Q1mUR4bVOTdX3+T3WTwGrj4pxWGx+c/Y2mIRc9qMU4wmt0z0MXUZN5D2oy2gj0P7muazHVTQKrrYvyTXX3kZX/fmOmkdSxjRx2HGFcRZMONmoyj+bsa00uYuS1OSJ/W9fjtS4SWG1fkJtzeJY+R6YmagIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUL5/BRgAj+eZMO1ZrYkAAAAASUVORK5CYII=', '3', '2024-08-14', '2024-09-14'),
(1, '風の歌を聴け', '村上春樹', NULL, '4', NULL, NULL),
(1, '未知の本', NULL, 'data:image/png;base64,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', '2', '2024-08-28', '2024-09-28');

-- -- メモデータの挿入
INSERT INTO Memos (book_id, user_id, content) VALUES 
(1, 'user1', '物語の設定が興味深い。社会の在り方について考えさせられる。'),
(2, 'user1', NULL),
(3, 'user2', '著者不明だが、タイトルに惹かれて購入。早く読みたい。');

-- DML セクション終了