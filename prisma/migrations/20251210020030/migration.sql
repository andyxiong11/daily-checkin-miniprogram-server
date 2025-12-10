/*
  Warnings:

  - You are about to drop the column `createdAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - Added the required column `openid` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updateTime` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userNickName` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Task" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "sort" INTEGER NOT NULL,
    "createTime" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" DATETIME NOT NULL,
    CONSTRAINT "Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "DailyTask" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "taskId" INTEGER,
    "date" DATETIME NOT NULL,
    "title" TEXT NOT NULL,
    "isCompleted" BOOLEAN NOT NULL DEFAULT false,
    "createTime" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" DATETIME NOT NULL,
    CONSTRAINT "DailyTask_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "DailyTask_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "DailySummary" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "date" DATETIME NOT NULL,
    "totalTasks" INTEGER NOT NULL,
    "completedTasks" INTEGER NOT NULL DEFAULT 0,
    "createTime" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" DATETIME NOT NULL,
    CONSTRAINT "DailySummary_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "openid" TEXT NOT NULL,
    "userNickName" TEXT NOT NULL,
    "reminderSet" BOOLEAN NOT NULL DEFAULT false,
    "subscribedTemplateId" TEXT,
    "createTime" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateTime" DATETIME NOT NULL
);
INSERT INTO "new_User" ("id") SELECT "id" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_openid_key" ON "User"("openid");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "DailyTask_userId_date_taskId_key" ON "DailyTask"("userId", "date", "taskId");

-- CreateIndex
CREATE UNIQUE INDEX "DailySummary_userId_date_key" ON "DailySummary"("userId", "date");
