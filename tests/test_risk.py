import unittest
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "services/correlation-engine"))
from risk import priority

class RiskTest(unittest.TestCase):
    def test_unknown(self):
        self.assertEqual(priority("unknown", True, True), "review")
    def test_affected(self):
        self.assertEqual(priority("affected", True, False), "high")
        self.assertEqual(priority("affected", False, False), "medium")
    def test_unaffected(self):
        self.assertEqual(priority("not_affected", True, True), "not_applicable")
    def test_invalid(self):
        with self.assertRaises(ValueError):
            priority("invalid", False, False)

if __name__ == "__main__":
    unittest.main()
