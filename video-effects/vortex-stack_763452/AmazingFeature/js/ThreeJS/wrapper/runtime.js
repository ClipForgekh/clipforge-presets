/**
 * 场景实例存储模块
 * 提供获取、设置、清空当前场景的接口
 */

let currentScene = null;

function getCurrentScene() {
  if (!currentScene) {
    console.warn('Scene实例尚未创建');
  }
  return currentScene;
}

function setCurrentScene(scene) {
  currentScene = scene;
}

function clearCurrentScene() {
  currentScene = null;
}

exports.getCurrentScene = getCurrentScene;
exports.setCurrentScene = setCurrentScene;
exports.clearCurrentScene = clearCurrentScene;


