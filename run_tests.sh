#!/bin/bash
# run_tests.sh - Script chạy tests cho My Finance App
# Sử dụng: bash run_tests.sh unit          (chạy unit tests)
#         bash run_tests.sh integration    (chạy integration tests)
#         bash run_tests.sh all           (chạy cả hai)

if [ -z "$1" ]; then
    echo "❌ Chưa chỉ định loại test!"
    echo ""
    echo "Cách dùng:"
    echo "  bash run_tests.sh unit          # Chạy Unit Tests"
    echo "  bash run_tests.sh integration   # Chạy Integration Tests (Web)"
    echo "  bash run_tests.sh integration-desktop  # Integration Tests (Windows Desktop)"
    echo "  bash run_tests.sh all           # Chạy cả Unit & Integration"
    echo "  bash run_tests.sh coverage      # Unit Tests + Coverage Report"
    exit 1
fi

case "$1" in
    unit)
        echo "🧪 Chạy Unit Tests..."
        echo "════════════════════════════════════"
        flutter test test/unit_test/
        ;;
    
    integration)
        echo "🎬 Chạy Integration Tests (Web)..."
        echo "════════════════════════════════════"
        flutter test test/integration_test/ --web
        ;;
    
    integration-desktop)
        echo "🎬 Chạy Integration Tests (Windows Desktop)..."
        echo "════════════════════════════════════"
        flutter test test/integration_test/ -d windows
        ;;
    
    all)
        echo "🧪 Chạy Unit Tests..."
        echo "════════════════════════════════════"
        flutter test test/unit_test/
        
        echo ""
        echo "🎬 Chạy Integration Tests (Web)..."
        echo "════════════════════════════════════"
        flutter test test/integration_test/ --web
        
        echo ""
        echo "✅ Tất cả tests đã hoàn thành!"
        ;;
    
    coverage)
        echo "📊 Chạy Unit Tests + Coverage Report..."
        echo "════════════════════════════════════"
        flutter test test/unit_test/ --coverage
        echo ""
        echo "✅ Coverage report tạo tại: coverage/lcov.info"
        ;;
    
    *)
        echo "❌ Tùy chọn không hợp lệ: $1"
        echo ""
        echo "Các tùy chọn hợp lệ:"
        echo "  unit              - Unit Tests"
        echo "  integration       - Integration Tests (Web)"
        echo "  integration-desktop - Integration Tests (Windows)"
        echo "  all               - Cả Unit & Integration Tests"
        echo "  coverage          - Unit Tests + Coverage"
        exit 1
        ;;
esac
