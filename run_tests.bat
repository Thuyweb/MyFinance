@echo off
REM run_tests.bat - Script chạy tests cho My Finance App (Windows)
REM Sử dụng: run_tests unit          (chạy unit tests)
REM         run_tests integration    (chạy integration tests)
REM         run_tests all           (chạy cả hai)

if "%1"=="" (
    echo.
    echo ❌ Chưa chỉ định loại test!
    echo.
    echo Cách dùng:
    echo   run_tests unit          - Chạy Unit Tests
    echo   run_tests integration   - Chạy Integration Tests (Web)
    echo   run_tests integration-desktop - Integration Tests (Windows)
    echo   run_tests all           - Chạy cả Unit ^& Integration
    echo   run_tests coverage      - Unit Tests + Coverage Report
    echo.
    exit /b 1
)

if "%1"=="unit" (
    echo.
    echo 🧪 Chạy Unit Tests...
    echo ════════════════════════════════════
    echo.
    flutter test test/unit_test/
    goto :end
)

if "%1"=="integration" (
    echo.
    echo 🎬 Chạy Integration Tests (Web)...
    echo ════════════════════════════════════
    echo.
    flutter test test/integration_test/ --web
    goto :end
)

if "%1"=="integration-desktop" (
    echo.
    echo 🎬 Chạy Integration Tests (Windows Desktop)...
    echo ════════════════════════════════════
    echo.
    flutter test test/integration_test/ -d windows
    goto :end
)

if "%1"=="all" (
    echo.
    echo 🧪 Chạy Unit Tests...
    echo ════════════════════════════════════
    echo.
    flutter test test/unit_test/
    
    echo.
    echo 🎬 Chạy Integration Tests (Web)...
    echo ════════════════════════════════════
    echo.
    flutter test test/integration_test/ --web
    
    echo.
    echo ✅ Tất cả tests đã hoàn thành!
    goto :end
)

if "%1"=="coverage" (
    echo.
    echo 📊 Chạy Unit Tests + Coverage Report...
    echo ════════════════════════════════════
    echo.
    flutter test test/unit_test/ --coverage
    
    echo.
    echo ✅ Coverage report tạo tại: coverage/lcov.info
    goto :end
)

echo.
echo ❌ Tùy chọn không hợp lệ: %1
echo.
echo Các tùy chọn hợp lệ:
echo   unit              - Unit Tests
echo   integration       - Integration Tests (Web)
echo   integration-desktop - Integration Tests (Windows)
echo   all               - Cả Unit ^& Integration Tests
echo   coverage          - Unit Tests + Coverage
echo.
exit /b 1

:end
